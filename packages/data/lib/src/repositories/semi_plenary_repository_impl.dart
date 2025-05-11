import 'package:data/data.dart';
import 'package:data/src/data_sources/data_sources.dart';
import 'package:data/src/data_sources/table/register_semi_plenary_table.dart';
import 'package:domain/domain.dart';
import 'package:entities/entities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';

class SemiPlenaryRepositoryImpl extends SemiPlenaryRepository {
  final db = FirebaseDatabase.instance.ref();

  @override
  Future<String?> readQr(String code) async {


    return "";
  }


  @override
  Future<List<SemiPlenary>> semiPlenaries() async {
    var list = HiveService.semiPlenaryBox.values.map((e) => e.toEntity()).toList();
    list.sort((a, b) => (a.title ?? "").compareTo(b.title ?? ""));
    return list;
  }

  @override
  Future<void> updateSemiPlenaries() async {
    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;
    if(user!=null){
      final registerEventRef = db.child('${ConstFirebase.eventPath}/${ConstFirebase.registerPlenaryPath}/${user.document}');
      bool pendingUpdate = user.pendingUpdate??false;

      if(pendingUpdate){
        final List<RegisterSemiPlenary> registerSemiPlenaries = HiveService.registerSemiPlenaryTableBox.values.map((e) => e.toEntity())
            .toList();
        try{
          final map = <String, Object>{};
          for (final semiPlenary in registerSemiPlenaries) {
            map["${semiPlenary.semiPlenary}_${semiPlenary.document}"] = {
              'document': user.document,
              'group': semiPlenary.group,
              'title': semiPlenary.title,
              'timestamp': DateTime.now().toIso8601String(),
            };
          }

          await registerEventRef.set(map);
          final updatedUser = user
            ..pendingUpdate = false;
          await HiveService.userBox.put(user.document, updatedUser);
        }catch(e){
          await FBUtils.tryLog('No se pudo volver a enlazar en el evento al usuario a');
          for (final semiPlenary in registerSemiPlenaries) {
            await FBUtils.tryLog('semiplenaria: ${semiPlenary.semiPlenary}');;
          }
          await FBUtils.tryRecordError(e);
        }
      }
    }

    final DatabaseReference ref = FirebaseDatabase.instance.ref("${ConstFirebase.eventPath}/${ConstFirebase.plenaryPath}");
    final DataSnapshot snapshot = await ref.get();
    if (snapshot.exists && snapshot.value is Map) {
      await HiveService.semiPlenaryBox.clear();
      final data = snapshot.value as Map;

      data.entries.map((entry) async{
        final id = entry.key;
        final json = Map<String, dynamic>.from(entry.value);
        await HiveService.semiPlenaryBox.put(
            id,
            SemiPlenaryTable()
              ..id = id
              ..color = json['color']
              ..group = json['group']
              ..issue = json['issue']
              ..title = json['title']
              ..time = json['time']
              ..capacity = json['capacity']
               ..available = json["available"]
        );
      }).toList();
    } else {
      // Firebase está accesible pero el nodo no existe
      await HiveService.semiPlenaryBox.clear();
    }

    final registerEventRef = db.child('${ConstFirebase.eventPath}/${ConstFirebase.registerPlenaryPath}/${user!.document}');
    final DataSnapshot registerEventSnapshot = await registerEventRef.get();
    if (registerEventSnapshot.exists && registerEventSnapshot.value is Map) {
      await HiveService.registerSemiPlenaryTableBox.clear();
      final data = registerEventSnapshot.value as Map;
      data.entries.map((entry) async{
        final id = entry.key;
        final json = Map<String, dynamic>.from(entry.value);
        await HiveService.registerSemiPlenaryTableBox.put(
            "${id}_${json['document']}",
            RegisterSemiPlenaryTable()
              ..semiPlenary = id
              ..group = json['group']
              ..document = json['document']
              ..title = json['title']
              ..timestamp = DateTime.parse(json['timestamp'])
        );
      }).toList();
    } else {
      await HiveService.registerSemiPlenaryTableBox.clear();
    }
  }

  @override
  Future<Either<RegisterSemiPlenaryFailure, void>> registerSemiPlenary(List<SemiPlenary> semiPlenaries) async {

    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;
    if (user?.document == null) return Left(UserNotExist());

    final session = FirebaseAuth.instance.currentUser?.uid;
    if (session == null) return Left(SessionNotExist());

    final registerEventRef = db.child('${ConstFirebase.eventPath}/${ConstFirebase.registerPlenaryPath}/${user!.document}');
    final existing = await registerEventRef.get();
    if (existing.exists) {
      return Left(UserHasRegisteredInSemiPlenary(user: user.name ?? ""));
    }

    final plenaryRef = db.child('${ConstFirebase.eventPath}/${ConstFirebase.plenaryPath}');
    List<String> plenaryIdsWithoutCapacity = [];
    Map<String, dynamic> plenariesData = {};
    TransactionResult? transactionResult;
    try{
      transactionResult = await plenaryRef.runTransaction((currentData) {
        if (currentData is Map) {
          plenariesData = Map<String, dynamic>.from(currentData);
        }

        // Verificar disponibilidad
        for (final entry in plenariesData.entries) {
          final exist = semiPlenaries.any((element) => element.id == entry.key);
          if (exist) {
            final plenary = Map<String, dynamic>.from(entry.value);
            final capacity = plenary['capacity'] ?? 0;
            final registered = plenary['registered'] ?? 0;
            final available = capacity - registered;

            if (available <= 0) {
              plenaryIdsWithoutCapacity.add(entry.key);
              return Transaction.abort();
            }
          }
        }

        // Actualizar sesiones válidas
        for (final entry in plenariesData.entries) {
          final exist = semiPlenaries.any((element) => element.id == entry.key);
          if (exist) {
            final plenary = Map<String, dynamic>.from(entry.value);
            final capacity = plenary['capacity'] ?? 0;
            final registered = plenary['registered'] ?? 0;
            final available = capacity - registered;

            plenary['available'] = available - 1;
            plenary['registered'] = registered + 1;
            plenariesData[entry.key] = plenary;
          }
        }

        return Transaction.success(plenariesData);
      });
    }catch(e){

      if (e is FirebaseException && e.code == 'unavailable') {
        return Left(NoInternetRegisterSemiPlenary());
      }
      return Left(UnknownRegisterSemiPlenary());
    }


    if (transactionResult.committed) {
      try {

        await HiveService.registerSemiPlenaryTableBox.clear();

        for (final semiPlenary in semiPlenaries) {

          await HiveService.registerSemiPlenaryTableBox.put(
            "${semiPlenary.id}_${user.document}",
            RegisterSemiPlenaryTable.fromEntity(RegisterSemiPlenary(
              semiPlenary: semiPlenary.id,
              document: user.document,
              timestamp: DateTime.now(),
              group: semiPlenary.group??"",
              title: semiPlenary.title??""
            )),
          );
        }

        final map = <String, Object>{};
        for (final semiPlenary in semiPlenaries) {
          map[semiPlenary.id] = {
            'document': user.document,
            'group': semiPlenary.group,
            'title': semiPlenary.title,
            'timestamp': DateTime.now().toIso8601String(),
          };
        }
        await registerEventRef.set(map);

        final updatedUser = user
          ..pendingUpdate = false;
        await HiveService.userBox.put(user.document, updatedUser);

        await HiveService.semiPlenaryBox.clear();
        for (final entry in plenariesData.entries){

          final plenary = Map<String, dynamic>.from(entry.value);

          var capacity = 0;
          if(plenary.containsKey("capacity")){
            capacity = plenary['capacity'] ?? 0;
          }
          var available = 0;
          if(plenary.containsKey("available")){
            available = plenary['available'] ?? 0;
          }
          final color =  plenary['color'] ?? "";
          final group =  plenary['group'] ?? "";
          final issue =  plenary['issue'] ?? "";
          final title =  plenary['title'] ?? "";
          final time =  plenary['time'] ?? "";


          await HiveService.semiPlenaryBox.put(
              entry.key,
              SemiPlenaryTable()
                ..id =  entry.key
                ..group = group
                ..color = color
                ..issue = issue
                ..title = title
                ..time = time
               ..capacity = capacity
              ..available = available
          );

        }

        return Right(null);
      } catch (e) {

        await FBUtils.tryLog('No se pudo enlazar en el evento al usuario');
        for (final semiPlenary in semiPlenaries) {
          await FBUtils.tryLog('semiplenaria: ${semiPlenary.id}');;
        }
        await FBUtils.tryRecordError(e);
        final updatedUser = user
          ..pendingUpdate = true;
        await HiveService.userBox.put(user.document, updatedUser);

        return Left(NoInternetRegisterSemiPlenary());
      }

    } else if (plenaryIdsWithoutCapacity.isNotEmpty) {
      return Left(NoCapacityInSemiPlenaries(plenaryIdsWithoutCapacity: plenaryIdsWithoutCapacity));
    }

    return Left(UnknownRegisterSemiPlenary());

  }

  @override
  Future<List<RegisterSemiPlenary>> getRegisterSemiPlenaries() async {
    final List<RegisterSemiPlenary> registerSemiPlenaries = HiveService.registerSemiPlenaryTableBox.values.map((e) => e.toEntity()).toList();

    return registerSemiPlenaries;
  }

}
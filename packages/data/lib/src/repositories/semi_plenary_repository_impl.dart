import 'package:bcrypt/bcrypt.dart';
import 'package:data/src/data_sources/data_sources.dart';
import 'package:domain/domain.dart';
import 'package:entities/entities.dart';
import 'package:firebase_database/firebase_database.dart';

class SemiPlenaryRepositoryImpl extends SemiPlenaryRepository {
  @override
  Future<String?> readQr(String code) async {
    // Hashear
    final hashed = hashPassword(code);
    print('Hash bcrypt: $hashed');

    // Verificar
    final isValid = checkPassword('miClaveSegura123', hashed);
    print('¿Contraseña válida?: $isValid');

    return "";
  }

  String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  bool checkPassword(String plainPassword, String hashedPassword) {
    return BCrypt.checkpw(plainPassword, hashedPassword);
  }

  @override
  Future<List<SemiPlenary>> semiPlenaries() async {
    var list = HiveService.semiPlenaryBox.values.map((e) => e.toEntity()).toList();
    list.sort((a, b) => (a.title ?? "").compareTo(b.title ?? ""));
    return list;
  }

  @override
  Future<void> updateSemiPlenaries() async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('semi-plenary');
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
              ..capacity = json['capacity'].toString()
        );
      }).toList();

    } else {
      // Firebase está accesible pero el nodo no existe
      await HiveService.semiPlenaryBox.clear();
    }
  }

}
import 'dart:async';

import 'package:data/src/data_sources/local_database.dart';
import 'package:domain/domain.dart';
import 'package:drift/drift.dart';
import 'package:entities/entities.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final _controller = StreamController<AuthStatus>();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;
  final AppDatabase _db = AppDatabase.getInstance();

  @override
  Future<bool> logIn(String document, String year) async {
    try {
      print('users/$document');
      final userSnapshot = await _dbRef.child('users/$document').get();
      if (!userSnapshot.exists) {
        return false;
      }
      final user = Map<String, dynamic>.from(userSnapshot.value as Map);
      print("user: $user");
      if (user['year'].toString() == year) {

        await _crashlytics.setUserIdentifier(document);
        await _analytics.setUserId(id: document);
        await _analytics.setUserProperty(name: 'nombre', value: user['name'] ?? '');
        await _db.into(_db.users).insertOnConflictUpdate(UsersCompanion.insert(
            document: document,
            year: Value(year),
            name: Value(user['name'].toString()),
            session: Value(Uuid().v4())
        ));
        _controller.add(AuthStatus.authenticated);
        return true;
      } else {
        await _crashlytics.setUserIdentifier(document);
        await FirebaseCrashlytics.instance.log('Intento fallido de login: contraseña incorrecta');
        await FirebaseCrashlytics.instance.recordError(
          Exception('Contraseña incorrecta para usuario $document ${year} ${user['name']}'),
          StackTrace.current,
        );
        return false;
      }
    }catch (e, stack) {
      await FirebaseCrashlytics.instance.recordError(e, stack);
      throw Exception('Error inesperado');
    }
  }

  @override
  Future<void> logOut() async {
    await _analytics.logEvent(name: 'logout');
    await _crashlytics.setUserIdentifier('');
    await _analytics.setUserId(id: null);
    await _db.delete(_db.users).go();
    _controller.add(AuthStatus.unauthenticated);
  }

  @override
  Stream<AuthStatus> get status async* {
    final user = await (_db.select(_db.users)..limit(1)).getSingleOrNull();

    await Future<void>.delayed(const Duration(seconds: 1));
    if (user != null) {
      yield AuthStatus.authenticated;
    } else {
      yield AuthStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  @override
  void dispose() => _controller.close();


}
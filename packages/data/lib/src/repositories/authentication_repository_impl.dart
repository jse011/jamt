import 'dart:async';

import 'package:domain/domain.dart';
import 'package:entities/entities.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../data_sources/data_sources.dart';


class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final _controller = StreamController<AuthStatus>();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  AuthenticationRepositoryImpl();

  @override
  Future<bool> logIn(String document, String year) async {
    try {
      print('users/$document');
      await trySetCrashlyticsUser(document);

      final userSnapshot = await _dbRef.child('users/$document').get();
      if (!userSnapshot.exists) {
        return false;
      }
      final user = Map<String, dynamic>.from(userSnapshot.value as Map);
      print("user: $user");
      if (user['year'].toString() == year) {

        await _analytics.setUserId(id: document);
        await _analytics.setUserProperty(name: 'nombre', value: user['name'] ?? '');

        await HiveService.userBox.put(
          document,
          UserTable.fromEntity(User(
            document: document,
            year: year,
            name: user['name'].toString(),
            session: Uuid().v4(),
          )),
        );

        _controller.add(AuthStatus.authenticated);
        return true;
      } else {

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
    await trySetCrashlyticsUser('');
    await _analytics.setUserId(id: null);
    await HiveService.userBox.clear();
    _controller.add(AuthStatus.unauthenticated);
  }

  @override
  Stream<AuthStatus> get status async* {
    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;
    print("status user: $user");
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

  Future<void> trySetCrashlyticsUser(String document) async {
    try {
      await FirebaseCrashlytics.instance.setUserIdentifier(document);
    } catch (e) {
      print('Otro error al configurar Crashlytics: $e');
    }
  }

}
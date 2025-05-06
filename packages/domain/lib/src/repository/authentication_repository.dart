import 'package:entities/entities.dart';

abstract class AuthenticationRepository {

  Stream<AuthStatus> get status;

  Future<bool> logIn(String document, String year);

  Future<void> logOut();

  void dispose();

}
import 'package:domain/src/repository/repository.dart';

class LogInUseCase {

  final AuthenticationRepository repository;

  LogInUseCase(this.repository);

  Future<bool> call(String document, String year) {
    return repository.logIn(document, year);
  }
}
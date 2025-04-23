part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.birthYear = const BirthYear.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Username username;
  final BirthYear birthYear;
  final bool isValid;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    BirthYear? birthYear,
    bool? isValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      birthYear: birthYear ?? this.birthYear,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, username, birthYear];
}


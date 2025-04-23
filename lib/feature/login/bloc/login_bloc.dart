import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jamt/feature/login/login.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginBirthYearChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
      LoginUsernameChanged event,
      Emitter<LoginState> emit,
      ) {
    final username = Username.pure(event.username);
    emit(
      state.copyWith(
        username: username,
      ),
    );
  }

  void _onPasswordChanged(
      LoginBirthYearChanged event,
      Emitter<LoginState> emit,
      ) {
    final birthYear = BirthYear.pure(event.birthYear);
    emit(
      state.copyWith(
        birthYear: birthYear,
      ),
    );
  }

  Future<void> _onSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    final username = Username.dirty(state.username.value);
    final birthYear = BirthYear.dirty(state.birthYear.value);

    emit(state.copyWith(
      username: username,
      birthYear: birthYear,
      isValid: Formz.validate([username, birthYear]),
    ));

    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.birthYear.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
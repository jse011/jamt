import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:jamt/feature/login/login.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LogInUseCase logIn,
  })  : _logIn = logIn,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginBirthYearChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final LogInUseCase _logIn;

  void _onUsernameChanged(
      LoginUsernameChanged event,
      Emitter<LoginState> emit,
      ) {
    final username = Username.pure(event.username);
    emit(
      state.copyWith(
        username: username,
        status:  FormzSubmissionStatus.initial,
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
        status:  FormzSubmissionStatus.initial,
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
      status:  FormzSubmissionStatus.initial,
      isValid: Formz.validate([username, birthYear]),
    ));

    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        var success = await _logIn.call(state.username.value, state.birthYear.value,);
        if(success){
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        }else{
          emit(state.copyWith(status: FormzSubmissionStatus.failure));
        }
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.canceled));
      }
    }
  }
}
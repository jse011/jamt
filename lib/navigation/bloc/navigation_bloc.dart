import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
import 'package:jamt/navigation/navigation.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc
    extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const NavigationState.unknown()) {
    on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthenticationLogoutPressed>(_onLogoutPressed);
    on<NavigationPressed>(_onNavigationPressed);
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  Future<void> _onSubscriptionRequested(
      AuthenticationSubscriptionRequested event,
      Emitter<NavigationState> emit,
      ) {
    return emit.onEach(
      _authenticationRepository.status,
      onData: (status) async {
        switch (status) {
          case AuthenticationStatus.unauthenticated:
            return emit(const NavigationState.unauthenticated());
          case AuthenticationStatus.authenticated:
            final user = await _tryGetUser();
            return emit(
              user != null
                  ? NavigationState.authenticated(user)
                  : const NavigationState.unauthenticated(),
            );
          case AuthenticationStatus.unknown:
            return emit(const NavigationState.unknown());
        }
      },
      onError: addError,
    );
  }

  void _onNavigationPressed(
        NavigationPressed event,
        Emitter<NavigationState> emit,
      ){
    emit(
        state.copyWith(
            destination: event.destination,
            initial: false,
            forceUpdate: DateTime.timestamp().millisecond
        )
    );
  }

  void _onLogoutPressed(
      AuthenticationLogoutPressed event,
      Emitter<NavigationState> emit,
      ) {
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
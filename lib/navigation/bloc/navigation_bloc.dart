import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:jamt/navigation/navigation.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc
    extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc({
    required GetAuthStatusUseCase getAuthStatus,
    required LogOutUseCase logOutUseCase,
    required GetUserUseCase getUserUseCase
  })  : _getAuthStatus = getAuthStatus,
        _logOutUseCase = logOutUseCase,
        _getUserUseCase = getUserUseCase,
        super(const NavigationState.unknown()) {
    on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthenticationLogoutPressed>(_onLogoutPressed);
    on<NavigationPressed>(_onNavigationPressed);
  }

  final GetAuthStatusUseCase _getAuthStatus;
  final LogOutUseCase _logOutUseCase;
  final GetUserUseCase _getUserUseCase;

  Future<void> _onSubscriptionRequested(
      AuthenticationSubscriptionRequested event,
      Emitter<NavigationState> emit,
      ) {
    return emit.onEach(
      _getAuthStatus.call(),
      onData: (status) async {
        switch (status) {
          case AuthStatus.unauthenticated:
            return emit(const NavigationState.unauthenticated());
          case AuthStatus.authenticated:
            final user = await _tryGetUser();
            return emit(
              user != null
                  ? NavigationState.authenticated(user)
                  : const NavigationState.unauthenticated(),
            );
          case AuthStatus.unknown:
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
    _logOutUseCase.call();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _getUserUseCase.call();
      return user;
    } catch (_) {
      return null;
    }
  }
}
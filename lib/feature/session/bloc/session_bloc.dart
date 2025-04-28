import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jamt/feature/session/session.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc() : super(SessionState()) {
    on<TabSelected>(_onTabSelected);
    on<OneSessionSelected>(_onOneSessionSelected);
    on<TwoSessionSelected>(_onTwoSessionSelected);
    on<OneSessionSave>(_onOneSessionSave);
    on<TwoSessionSave>(_onTwoSessionSave);
    on<OneSessionClose>(_onOneSessionClose);
    on<TwoSessionClose>(_onTwoSessionClose);
    on<SessionRegister>(_onSessionRegister);

  }
  void _onTabSelected(TabSelected event,  Emitter<SessionState> emit) {
    emit(state.copyWith(
        selectedIndex:  event.selectedIndex
    ));

  }

  void _onOneSessionSelected(OneSessionSelected event,  Emitter<SessionState> emit) {

    emit(state.copyWith(
        oneSelected:  event.selectedIndex
    ));
  }

  void _onTwoSessionSelected(TwoSessionSelected event,  Emitter<SessionState> emit) {

    emit(state.copyWith(
        twoSelected:  event.selectedIndex
    ));
  }

  void _onOneSessionSave(OneSessionSave event,  Emitter<SessionState> emit) {
    emit(state.copyWith(
        saveOneSession:  state.sessions[state.oneSelected]
    ));
  }

  void _onTwoSessionSave(TwoSessionSave event,  Emitter<SessionState> emit) {

    emit(state.copyWith(
        saveTwoSession:  state.sessions[state.twoSelected]
    ));
  }

  void _onOneSessionClose(OneSessionClose event,  Emitter<SessionState> emit) {
    emit(state.copyWith(
        saveOneSession:  SessionSelected()
    ));
  }

  void _onTwoSessionClose(TwoSessionClose event,  Emitter<SessionState> emit) {

    emit(state.copyWith(
        saveTwoSession: SessionSelected()
    ));
  }

  void _onSessionRegister(SessionRegister event,  Emitter<SessionState> emit) {
    emit(state.copyWith(
        register: true
    ));
  }
}

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jamt/feature/semi_plenary/semi_plenary.dart';

part 'semi_plenary_event.dart';
part 'semi_plenary_state.dart';

class SemiPlenaryBloc extends Bloc<SemiPlenaryEvent, SemiPlenaryState> {
  SemiPlenaryBloc({
    required GetSemiPlenariesUseCase getSemiPlenariesUseCase,
    required UpdateSemiPlenariesUseCase updateSemiPlenariesUseCase}) :
        _getSemiPlenariesUseCase = getSemiPlenariesUseCase,
        _updateSemiPlenariesUseCase = updateSemiPlenariesUseCase,
        super(SemiPlenaryState()) {
    on<LoadSemiPlenary>(_onSemiPlenarySubscriptionRequested);
    on<TabSelected>(_onTabSelected);
    on<SessionSelected>(_onOneSessionSelected);
    on<SessionSave>(_onOneSessionSave);
    on<SessionClose>(_onOneSessionClose);
    on<SessionRegister>(_onSessionRegister);

  }

  final GetSemiPlenariesUseCase _getSemiPlenariesUseCase;
  final UpdateSemiPlenariesUseCase _updateSemiPlenariesUseCase;

  void _onSemiPlenarySubscriptionRequested(LoadSemiPlenary event,  Emitter<SemiPlenaryState> emit) async{
    state.copyWith(progress: true);
    try{
      await _updateSemiPlenariesUseCase.call();
      emit(state.copyWith(
          progress: true,
          offline: false
      ));
      print("sucess");
    }catch(e){
      print("error: $e");
      emit(state.copyWith(
          progress: true,
          offline: true
      ));
    }


    List<Session> sessions = (await  _getSemiPlenariesUseCase.call()).map((semiPlenary){
      return Session(
        id: semiPlenary.id,
        group: semiPlenary.group??"",
        title: semiPlenary.title??""
      );
    }).toList();
    print("sessions: ${sessions.length}");
    final Map<String, List<Session>> groupedMap = {};

    for (var session in sessions) {
      groupedMap.putIfAbsent(session.group, () => []).add(session);
    }

    final List<SessionGroup> groupedSessions = groupedMap.entries.map((entry) {
      var list = entry.value;
      list.insert(0, Session(id: "", title: "SELECCIONE"));
      return SessionGroup(group: entry.key, sessions: list);
    }).toList();

    groupedSessions.sort((a, b) => (a.group).compareTo((b.group)));

    var semiPlenaries = await  _getSemiPlenariesUseCase.call();
    final Map<String, List<SemiPlenary>> groupedTabMap = {};
    for (var semiPlenary in semiPlenaries) {
      groupedTabMap.putIfAbsent(semiPlenary.group??"", () => []).add(semiPlenary);
    }

    final List<SemiPlenaryTab> groupedSessionTabs = groupedTabMap.entries.map((entry) {
      return SemiPlenaryTab(title: entry.key, session: entry.value.map((semiPlenary){
        return SessionCard(
            title: semiPlenary.title??"",
            topic2: semiPlenary.time??"",
            color: hexToColor(semiPlenary.color??""),
            capacity: semiPlenary.capacity??""
        );
      }).toList());
    }).toList();

    groupedSessionTabs.sort((a, b) => (a.title).compareTo((b.title)));

    emit(
        state.copyWith(
            groupedSessions: groupedSessions,
            tabs: groupedSessionTabs,
            progress: false
        ));
  }

  void _onTabSelected(TabSelected event,  Emitter<SemiPlenaryState> emit) {
    emit(state.copyWith(
        selectedIndex: event.selectedIndex
    ));
  }

  void _onOneSessionSelected(SessionSelected event,  Emitter<SemiPlenaryState> emit) {
    final updatedGroups = state.groupedSessions.map((group) {
      if (group == event.groupSelected) {
        return group.copyWith(
          selected: event.selected
        );
      }
      return group;
    }).toList();
    emit(state.copyWith(
      groupedSessions: updatedGroups
    ));
  }

  void _onOneSessionSave(SessionSave event,  Emitter<SemiPlenaryState> emit) {
    print("_onOneSessionSave");
    final updatedGroups = state.groupedSessions.map((group) {
      if (group == event.groupSelected) {
        return group.copyWith(
            register: (group.selected?.id != null && group.selected?.id != "")? true: false
        );
      }
      return group;
    }).toList();

    emit(state.copyWith(
      groupedSessions: updatedGroups
    ));
  }

  void _onOneSessionClose(SessionClose event,  Emitter<SemiPlenaryState> emit) {
    final updatedGroups = state.groupedSessions.map((group) {
      if (group == event.groupSelected) {
        return group.copyWith(
            register: false
        );
      }
      return group;
    }).toList();
    print("_onOneSessionClose");
    emit(state.copyWith(
        groupedSessions: updatedGroups
    ));
  }

  void _onSessionRegister(SessionRegister event,  Emitter<SemiPlenaryState> emit) {
    emit(state.copyWith(
        register: true
    ));
  }

  Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // Añade opacidad completa si no está
    }
    return Color(int.parse(hex, radix: 16));
  }
}

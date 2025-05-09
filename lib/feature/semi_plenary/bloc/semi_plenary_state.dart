part of 'semi_plenary_bloc.dart';

class SemiPlenaryState extends Equatable {
  final bool offline;
  final bool progress;
  final List<SemiPlenaryTab> tabs;
  final List<SessionGroup> groupedSessions;
  final bool register;
  final int selectedIndex;

  const SemiPlenaryState({
    this.offline = false,
    this.progress = true,
    this.register = false,
    this.groupedSessions = const [],
    this.selectedIndex = 0,
    this.tabs = const []});

  SemiPlenaryState copyWith({
    List<SemiPlenaryTab>? tabs,
    int? selectedIndex,
    SessionSelected? saveOneSession,
    SessionSelected? saveTwoSession,
    bool? register,
    List<SessionGroup>? groupedSessions,
    bool? progress,
    bool? offline,
  }){
    return SemiPlenaryState(
        tabs: tabs??this.tabs,
        register: register??this.register,
        groupedSessions: groupedSessions ?? this.groupedSessions,
        selectedIndex: selectedIndex??this.selectedIndex,
        progress: progress??this.progress,
        offline: offline??this.offline
    );
  }


  @override
  List<Object?> get props => [groupedSessions, tabs, register, progress, offline, selectedIndex];

}

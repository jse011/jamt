import 'package:equatable/equatable.dart';
import '../models/models.dart';

class SessionGroup extends Equatable{

  final String group;
  final List<Session> sessions;
  final Session? selected;
  final bool register;

  const SessionGroup({this.group = "", this.sessions = const [], this.selected, this.register = false});

  SessionGroup copyWith({
    String? group,
    List<Session>? sessions,
    Session? selected,
    bool? register
  }){
    return SessionGroup(
      group: group??this.group,
      sessions: sessions??this.sessions,
      selected: selected??this.selected,
      register: register??this.register
    );
  }
  @override
  List<Object?> get props => [group, sessions, selected, register];
}
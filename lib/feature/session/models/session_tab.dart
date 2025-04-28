import 'package:equatable/equatable.dart';
import 'package:jamt/feature/session/models/session_card.dart';

final class SessionTab extends Equatable {

  final String title;
  final List<SessionCard> session;

  const SessionTab({this.title = "", this.session = const []});

  @override
  List<Object?> get props => [title, session];

}
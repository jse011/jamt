import 'package:equatable/equatable.dart';
import '../models/models.dart';

final class SemiPlenaryTab extends Equatable {

  final String title;
  final List<SessionCard> session;

  const SemiPlenaryTab({this.title = "", this.session = const []});

  @override
  List<Object?> get props => [title, session];

}
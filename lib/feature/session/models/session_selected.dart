import 'package:equatable/equatable.dart';

class SessionSelected extends Equatable {

  final int id;
  final String title;

  const SessionSelected({this.id = 0, this.title = ""});

  @override
  List<Object?> get props => [id, title];

}
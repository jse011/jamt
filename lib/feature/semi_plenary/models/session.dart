import 'package:equatable/equatable.dart';

class Session extends Equatable {

  final String id;
  final String title;
  final String group;

  const Session({this.id = "", this.title = "", this.group = ""});

  @override
  List<Object?> get props => [id, title, group];

}
import 'package:equatable/equatable.dart';

class Session extends Equatable {

  final String id;
  final String title;
  final String group;

  const Session({this.id = "", this.title = "", this.group = ""});

  @override
  List<Object?> get props => [id, title, group];

  Session copyWith({
    String? id,
   String? title,
    String? group
  }){
    return Session(
        id: id??this.id,
        title: title??this.title,
        group: group??this.group
    );
  }

}
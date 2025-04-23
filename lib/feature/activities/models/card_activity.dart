 import 'package:equatable/equatable.dart';

final class CardActivity extends Equatable{
  final String title;
  final String body;
  final String image;

  const CardActivity({this.title = "", this.body = "", this.image = ""});

  @override
  List<Object?> get props => [title, body, image];

}
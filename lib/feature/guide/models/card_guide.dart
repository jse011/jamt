import 'package:equatable/equatable.dart';

class CardGuide extends Equatable {
  final String title;
  final String body;

  const CardGuide({this.title = "", this.body = "",});

  @override
  List<Object?> get props => [title, body];

}
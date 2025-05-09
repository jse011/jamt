import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SessionCard extends Equatable {
  final Color color;
  final String title;
  final String topic;
  final String topic2;
  final String capacity;
  final String description;
  final List<SessionCard> guests;

  const SessionCard({this.color = Colors.white70, this.title = "", this.topic = "", this.topic2 = "", this.description = "", this.guests = const [], this.capacity = ""});

  @override
  List<Object?> get props => [title, guests, description, guests, color, topic, topic2, capacity];
}
import 'package:flutter/material.dart';

enum Destination {

  tabHome(Icons.home, 'Inicio'),
  sessions(Icons.bookmark, 'Semiplenarias'),
  profile(Icons.person, 'Mis datos'),
  guests(Icons.groups, 'Invitados'),
  organization(Icons.badge, 'Organización'),
  bulletins(Icons.article, 'Boletines'),
  health(Icons.healing, 'Puestos de Salud'),
  news(Icons.newspaper, 'Noticias'),
  videos(Icons.video_collection, 'Videos'),
  trivia(Icons.tour, 'Trivia'),
  map(Icons.map, 'Mapa'),
  menu(Icons.menu, 'Menú');

  const Destination(this.icon, this.label);

  final IconData icon;
  final String label;

}
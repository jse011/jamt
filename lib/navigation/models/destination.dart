import 'package:flutter/material.dart';
import 'package:jamt/constants/app_icon.dart';

enum Destination {

  tabHome(AppIcon.home, 'Inicio'),
  sessions(Icons.bookmark, 'Semiplenarias'),
  profile(Icons.person, 'Mis datos'),
  qr(AppIcon.qrcode, 'Escanear'),
  guests(Icons.groups, 'Invitados'),
  bulletins(Icons.article, 'Boletines'),
  trivia(Icons.tour, 'Trivia'),
  map(AppIcon.map, 'Mapa'),
  menu(Icons.menu, 'Menú'),
  logout(Icons.logout, 'Cerrar Sesion');

  const Destination(this.icon, this.label);

  final IconData icon;
  final String label;

}
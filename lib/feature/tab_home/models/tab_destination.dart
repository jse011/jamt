import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';

enum TabDestination {

  guide(AppIcon.book, 'Guía', AppColor.blue2, AppColor.purpleDark),
  schedule(AppIcon.calendar, 'Agenda', AppColor.blueLight, AppColor.yellow),
  home(AppIcon.home, 'Inicio', AppColor.blue2, AppColor.purpleDark),
  map(AppIcon.map, 'Mapa', AppColor.yellow, AppColor.colorPrimary),
  menu(AppIcon.menu, 'Menú', AppColor.yellow, AppColor.colorPrimary),

  activities(Icons.home, '',AppColor.purpleDark, AppColor.blue2, parent: TabDestination.home),
  guests(Icons.home, '', AppColor.blueLight, AppColor.yellow,parent: TabDestination.home),
  bulletin(Icons.home, '', AppColor.blue2,AppColor.yellow, parent: TabDestination.home),
  workshops(Icons.home, '', AppColor.colorPrimary, AppColor.yellow, parent: TabDestination.home),
  sessions(Icons.home, '', AppColor.blueLight, AppColor.purpleDark2, parent: TabDestination.home),
  tourism(Icons.home, '', AppColor.yellow, AppColor.colorPrimary, parent: TabDestination.home),
  stands(Icons.home, '', AppColor.blueLight, AppColor.yellow, parent: TabDestination.home),
  mainObjectives(Icons.home, '', AppColor.colorPrimary, AppColor.yellow, parent: TabDestination.home),
  event(Icons.home, '',AppColor.blueDark, AppColor.purpleLight, parent: TabDestination.home);
  const TabDestination(this.icon, this.label, this.color1, this.color2, {this.parent});

  final IconData icon;
  final String label;
  final Color color1;
  final Color color2;
  final TabDestination? parent;
}
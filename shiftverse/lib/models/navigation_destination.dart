import 'package:flutter/material.dart';

class Destination {
  const Destination(
      {required this.activeIcon, required this.icon, required this.label});
  final Icon activeIcon;
  final Icon icon;
  final String label;
}

List<Destination> navDestinations = <Destination>[
  const Destination(
      activeIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
      label: 'Home'),
  const Destination(
      activeIcon: Icon(Icons.bar_chart_rounded),
      icon: Icon(Icons.bar_chart_outlined),
      label: 'Reports'),
  const Destination(
      activeIcon: Icon(Icons.swap_vert_circle_rounded),
      icon: Icon(Icons.swap_vertical_circle_outlined),
      label: 'Shifts'),
  const Destination(
      activeIcon: Icon(Icons.account_circle_rounded),
      icon: Icon(Icons.account_circle_outlined),
      label: 'Profile'),
];

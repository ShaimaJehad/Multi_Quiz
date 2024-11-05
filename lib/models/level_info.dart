import 'package:flutter/material.dart';

class Level {
  final String title;
  final String subtitle;
  final String? desription;
  final String? image;
  final IconData? icon;
  final List<Color> colors;
  final String routeNames;

  Level({
    required this.title,
    required this.subtitle,
    this.desription,
    this.image,
    this.icon,
    required this.colors,
    required this.routeNames,
  });
}

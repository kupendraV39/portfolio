import 'package:flutter/material.dart';

class Experience {
  const Experience({
    required this.title,
    required this.companyName,
    required this.icon,
    required this.iconBg,
    required this.date,
    required this.points,
  });

  final String title;
  final String companyName;
  final String icon; // asset path
  final Color iconBg;
  final String date;
  final List<String> points;
}

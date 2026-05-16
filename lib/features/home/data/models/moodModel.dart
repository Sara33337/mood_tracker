import 'package:flutter/material.dart';

enum MoodType { happy, neutral, sad }

class MoodEntry {
  final MoodType type;
  final DateTime date;
  final Color color;

  MoodEntry({
    required this.type,
    required this.date,
    required this.color,
  });
}
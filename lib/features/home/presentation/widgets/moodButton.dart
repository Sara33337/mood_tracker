 import 'package:flutter/material.dart';
import 'package:painter/features/home/presentation/widgets/moodPainter.dart';
import 'package:painter/features/home/data/models/moodModel.dart';

class BuildLogButton extends StatelessWidget {
  final MoodType type;
  final Color color;
  final String label;
  final VoidCallback onPressed;

  const BuildLogButton({
    super.key,
    required this.type,
    required this.color,
    required this.label,
    required this.onPressed,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: color.withOpacity(0.15), blurRadius: 10, spreadRadius: 2),
              ],
            ),
            child: CustomPaint(
              size: const Size(60, 60),
              painter: MoodPainter(mood: type, baseColor: color),
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }}
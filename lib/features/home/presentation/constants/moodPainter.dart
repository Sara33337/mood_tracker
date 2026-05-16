import 'dart:math';
import 'package:flutter/material.dart';
import 'package:painter/features/home/data/models/moodModel.dart';

class MoodPainter extends CustomPainter {
  final MoodType mood;
  final Color baseColor;

  MoodPainter({required this.mood, required this.baseColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    // 1. Draw Face Background
    final facePaint = Paint()
      ..color = baseColor.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, facePaint);

    // 2. Draw Face Outline
    final outlinePaint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(center, radius, outlinePaint);

    // 3. Draw Eyes
    final eyePaint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.fill;
    
    final leftEyeOffset = Offset(center.dx - radius * 0.35, center.dy - radius * 0.2);
    final rightEyeOffset = Offset(center.dx + radius * 0.35, center.dy - radius * 0.2);
    final eyeRadius = radius * 0.1;
    
    canvas.drawCircle(leftEyeOffset, eyeRadius, eyePaint);
    canvas.drawCircle(rightEyeOffset, eyeRadius, eyePaint);

    // 4. Draw Specific Mood Features (Mouth & Eyebrows)
    final mouthPaint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    if (mood == MoodType.happy) {
      // Happy Smile Arc
      final mouthRect = Rect.fromCenter(
        center: Offset(center.dx, center.dy + radius * 0.1),
        width: radius * 0.8,
        height: radius * 0.5,
      );
      canvas.drawArc(mouthRect, 0, pi, false, mouthPaint);

    } else if (mood == MoodType.neutral) {
      // Neutral Straight Line Mouth
      canvas.drawLine(
        Offset(center.dx - radius * 0.3, center.dy + radius * 0.2),
        Offset(center.dx + radius * 0.3, center.dy + radius * 0.2),
        mouthPaint,
      );

    } else if (mood == MoodType.sad) {
      // Sad Frown Arc
      final mouthRect = Rect.fromCenter(
        center: Offset(center.dx, center.dy + radius * 0.4),
        width: radius * 0.8,
        height: radius * 0.5,
      );
      canvas.drawArc(mouthRect, pi, pi, false, mouthPaint);

      // Sad Angled Eyebrows
      final eyebrowPaint = Paint()
        ..color = baseColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      // Left Eyebrow (slanted up towards the center)
      canvas.drawLine(
        Offset(center.dx - radius * 0.5, center.dy - radius * 0.45),
        Offset(center.dx - radius * 0.15, center.dy - radius * 0.55),
        eyebrowPaint,
      );
      // Right Eyebrow (slanted up towards the center)
      canvas.drawLine(
        Offset(center.dx + radius * 0.5, center.dy - radius * 0.45),
        Offset(center.dx + radius * 0.15, center.dy - radius * 0.55),
        eyebrowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant MoodPainter oldDelegate) {
    return oldDelegate.mood != mood || oldDelegate.baseColor != baseColor;
  }
}
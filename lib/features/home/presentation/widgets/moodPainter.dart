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

    final facePaint = Paint()
      ..color = baseColor.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, facePaint);

    final outlinePaint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(center, radius, outlinePaint);

    final eyePaint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.fill;
    
    final leftEyeOffset = Offset(center.dx - radius * 0.35, center.dy - radius * 0.2);
    final rightEyeOffset = Offset(center.dx + radius * 0.35, center.dy - radius * 0.2);
    final eyeRadius = radius * 0.1;
    
    canvas.drawCircle(leftEyeOffset, eyeRadius, eyePaint);
    canvas.drawCircle(rightEyeOffset, eyeRadius, eyePaint);

    final mouthPaint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    if (mood == MoodType.happy) {
      final mouthRect = Rect.fromCenter(
        center: Offset(center.dx, center.dy + radius * 0.1),
        width: radius * 0.8,
        height: radius * 0.5,
      );
      canvas.drawArc(mouthRect, 0, pi, false, mouthPaint);

    } else if (mood == MoodType.neutral) {
      canvas.drawLine(
        Offset(center.dx - radius * 0.3, center.dy + radius * 0.2),
        Offset(center.dx + radius * 0.3, center.dy + radius * 0.2),
        mouthPaint,
      );

    } else if (mood == MoodType.sad) {
      final mouthRect = Rect.fromCenter(
        center: Offset(center.dx, center.dy + radius * 0.4),
        width: radius * 0.8,
        height: radius * 0.5,
      );
      canvas.drawArc(mouthRect, pi, pi, false, mouthPaint);


      final eyebrowPaint = Paint()
        ..color = baseColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      canvas.drawLine(
        Offset(center.dx - radius * 0.5, center.dy - radius * 0.45),
        Offset(center.dx - radius * 0.15, center.dy - radius * 0.55),
        eyebrowPaint,
      );

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
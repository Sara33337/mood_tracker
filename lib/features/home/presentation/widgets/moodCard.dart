import 'package:flutter/material.dart';
import 'package:painter/features/home/presentation/widgets/moodPainter.dart';
import 'package:painter/features/home/data/models/moodModel.dart';

class MoodCard extends StatefulWidget {
  final MoodEntry entry;
  const MoodCard({Key? key, required this.entry}) : super(key: key);

  @override
  State<MoodCard> createState() => _MoodCardState();
}

class _MoodCardState extends State<MoodCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerAnimation() {
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    // Format date beautifully (MM/DD)
    final dateString = "${widget.entry.date.month}/${widget.entry.date.day}/${widget.entry.date.year}";

    return GestureDetector(
      onTap: _triggerAnimation,
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          width: 100,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: widget.entry.color.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: widget.entry.color.withOpacity(0.5), width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dateString,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
              ),
              const SizedBox(height: 12),
              CustomPaint(
                size: const Size(50, 50),
                painter: MoodPainter(mood: widget.entry.type, baseColor: widget.entry.color),
              ),
              const SizedBox(height: 8),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: widget.entry.color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
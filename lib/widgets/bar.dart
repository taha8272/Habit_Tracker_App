import 'dart:math';
import 'package:car_rental/basic.dart';
import 'package:flutter/material.dart';
import '../models/habit.dart';

class RotatingHabitsChart extends StatefulWidget {
  final List<Habit> habits;
  final int maxStreak;

  const RotatingHabitsChart({
    super.key,
    required this.habits,
    this.maxStreak = 30, // define a month as max progress
  });

  @override
  State<RotatingHabitsChart> createState() => _RotatingHabitsChartState();
}

class _RotatingHabitsChartState extends State<RotatingHabitsChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 8),
      child: SizedBox(
        height: 200,
        width: 200,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return CustomPaint(
              painter: _HabitsPainter(
                habits: widget.habits,
                maxStreak: widget.maxStreak,
                rotation: _controller.value * 2 * pi,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HabitsPainter extends CustomPainter {
  final List<Habit> habits;
  final int maxStreak;
  final double rotation;

  _HabitsPainter({
    required this.habits,
    required this.maxStreak,
    required this.rotation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 3;

    // gradient-filled circle background
    final circleFill = Paint()
      ..shader = RadialGradient(
        colors: [
          lightColor, // center
          darkColor, // edge
        ],
        stops: const [0.3, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, circleFill);

    // circle border
    final circleBorder = Paint()
      ..color = darkColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(center, radius, circleBorder);

    // Draw "Habits" in center
    final centerText = TextPainter(
      text: TextSpan(
        text: "Habits",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();
    centerText.paint(
      canvas,
      center - Offset(centerText.width / 2, centerText.height / 2),
    );

    // bars
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap
          .butt // flat edges
      ..strokeWidth = 45;

    final count = habits.length;
    if (count == 0) return;

    for (int i = 0; i < count; i++) {
      final habit = habits[i];
      final angle = (2 * pi / count) * i + rotation;

      final streakRatio = (habit.streak / maxStreak).clamp(0.0, 1.0);

      final startOffset = 14.0; // offset to avoid overlap with circle border
      final extraLength = radius * streakRatio;

      // pull start back by half strokeWidth so flat side touches circle
      final start = Offset(
        center.dx + (radius + startOffset - paint.strokeWidth / 2) * cos(angle),
        center.dy + (radius + startOffset - paint.strokeWidth / 2) * sin(angle),
      );
      final end = Offset(
        center.dx + (radius + startOffset + extraLength) * cos(angle),
        center.dy + (radius + startOffset + extraLength) * sin(angle),
      );

      // draw bar (flat at inner side)
      paint.color = darkColor;
      canvas.drawLine(start, end, paint);

      // draw rounded cap at outer side
      final capPaint = Paint()
        ..color = darkColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(end, paint.strokeWidth / 2, capPaint);

      // Draw habit name along the bar (rotated)
      final labelPos = Offset(
        center.dx + (radius + startOffset + extraLength / 2) * cos(angle),
        center.dy + (radius + startOffset + extraLength / 2) * sin(angle),
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: habit.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();

      canvas.save();
      canvas.translate(labelPos.dx, labelPos.dy);
      canvas.rotate(angle);
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_HabitsPainter oldDelegate) {
    return oldDelegate.rotation != rotation || oldDelegate.habits != habits;
  }
}

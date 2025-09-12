import 'dart:math';
import 'package:flutter/material.dart';
import '../models/habit.dart';

class RadialHabitsChart extends StatefulWidget {
  final List<Habit> habits;
  final int maxStreak;

  const RadialHabitsChart({
    super.key,
    required this.habits,
    this.maxStreak = 30,
  });

  @override
  State<RadialHabitsChart> createState() => _RadialHabitsChartState();
}

class _RadialHabitsChartState extends State<RadialHabitsChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Complete Habit Goals to fill the circle'),
        SizedBox(
          height: 280,
          width: 280,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _RadialPainter(
                  habits: widget.habits,
                  maxStreak: widget.maxStreak,
                  progress: _controller.value,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RadialPainter extends CustomPainter {
  final List<Habit> habits;
  final int maxStreak;
  final double progress;

  _RadialPainter({
    required this.habits,
    required this.maxStreak,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final baseRadius = size.width / 3;
    final count = habits.length;
    if (count == 0) return;

    // Central hub
    final hubPaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.blue.shade800, Colors.black87],
      ).createShader(Rect.fromCircle(center: center, radius: baseRadius / 2));
    canvas.drawCircle(center, 40, hubPaint);

    final hubText = TextPainter(
      text: const TextSpan(
        text: "Habits",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();
    hubText.paint(
      canvas,
      center - Offset(hubText.width / 2, hubText.height / 2),
    );

    // Sweep angle for each arc (full circle split)
    final sweep = (2 * pi) / count;

    for (int i = 0; i < count; i++) {
      final habit = habits[i];
      final streakRatio = (habit.streak / maxStreak).clamp(0.0, 1.0);

      final startAngle = (sweep * i) - pi / 2;
      final sweepAngle = sweep * streakRatio * progress; // animate fill

      final rect = Rect.fromCircle(center: center, radius: baseRadius);

      // Gradient arc
      final paint = Paint()
        ..shader = SweepGradient(
          startAngle: startAngle,
          endAngle: startAngle + sweep,
          colors: [Colors.red, Colors.yellow, Colors.green],
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 16
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

      // Label outside arc
      final labelAngle = startAngle + sweep / 2;
      final labelOffset = Offset(
        center.dx + (baseRadius + 30) * cos(labelAngle),
        center.dy + (baseRadius + 30) * sin(labelAngle),
      );

      final label = TextPainter(
        text: TextSpan(
          text: "🔥 ${habit.streak}\n${habit.name}",
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();

      label.paint(
        canvas,
        labelOffset - Offset(label.width / 2, label.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RadialPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.habits != habits;
  }
}

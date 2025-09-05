import 'package:Habit_Goals_Tracker/basic.dart';
import 'package:Habit_Goals_Tracker/models/habit.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HabitTile extends ConsumerWidget {
  const HabitTile({super.key, required this.habit});
  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxScore = habit.goal;
    final progress = (habit.streak / maxScore).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: habit.category.color.withValues(alpha: 0.4),
        child: Container(
          decoration: BoxDecoration(
            gradient: habit.category.gradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Progress circle
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: progress),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutCubic,
                  builder: (context, animatedValue, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            value: animatedValue,
                            strokeWidth: 6,
                            backgroundColor: Colors.white24,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "${habit.streak}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(width: 16),

                // Habit name & streak label
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.name,
                        style: h1.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "🔥 Streak: ${habit.streak} days",
                        style: h2.copyWith(color: Colors.white70, fontSize: 15),
                      ),
                    ],
                  ),
                ),

                // Checkbox aligned at end
                Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  value: habit.isChecked,
                  onChanged: (value) {
                    final uid = FirebaseAuth.instance.currentUser!.uid;
                    final docRef = FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .collection('habits')
                        .doc(habit.id);

                    docRef.update({
                      'IsChecked': value,
                      'Streak': value! ? habit.streak + 1 : habit.streak,
                    });
                  },
                  checkColor: Colors.white,
                  activeColor: Colors.teal.shade400,
                  side: const BorderSide(color: Colors.white70, width: 1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

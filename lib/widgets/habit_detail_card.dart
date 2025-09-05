import 'package:Habit_Goals_Tracker/basic.dart';
import 'package:Habit_Goals_Tracker/models/habit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HabitDetailCard extends StatelessWidget {
  const HabitDetailCard({super.key, required this.habit});
  final Habit habit;

  void deleteHabit(BuildContext context, Habit habit) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final delete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Habit'),
        content: const Text('Are you sure you want to delete this habit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (delete == true) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('habits')
          .doc(habit.id)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      shadowColor: habit.category.color.withOpacity(0.4),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: habit.category.gradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Habit name
              Text(
                habit.name,
                style: h1.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 12),

              // Description + Goal / Streak
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LEFT SIDE: description
                    SizedBox(
                      width: screenWidth * 0.42,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Description\n',
                              style: h2.copyWith(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: habit.description,
                              style: text.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 4),
                    VerticalDivider(
                      color: Colors.white30,
                      thickness: 1.5,
                      indent: 4,
                      endIndent: 4,
                    ),
                    const SizedBox(width: 12),

                    // RIGHT SIDE: chips for goal and streak
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              Chip(
                                backgroundColor: lightColor.withValues(
                                  alpha: 0.1,
                                ),
                                label: Text(
                                  "🎯 Goal: ${habit.goal} days",
                                  style: const TextStyle(
                                    color: Color(0xFF0A344D),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Chip(
                                backgroundColor: lightColor.withValues(
                                  alpha: 0.1,
                                ),
                                label: Text(
                                  "🔥 Streak: ${habit.streak} days",
                                  style: const TextStyle(
                                    color: Color(0xFF0A344D),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Delete button bottom-right
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton.icon(
                              onPressed: () => deleteHabit(context, habit),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.white.withValues(
                                  alpha: 0.15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

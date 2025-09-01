import 'package:car_rental/basic.dart';
import 'package:car_rental/models/habit.dart';
import 'package:car_rental/providers/habits_list_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HabitTile extends ConsumerWidget {
  const HabitTile({super.key, required this.habit});
  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxScore = 30.0; // adjust as needed
    final progress = (habit.streak / maxScore);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0A344D), Color(0xFF1D6C8B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          // border: Border.all(width: 1.5, color: Color(0xFF0A344D)),
          borderRadius: BorderRadius.circular(25),
        ),

        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 15,
              right: 15,
              bottom: 7,
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Column(
                    children: [
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: progress),
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeOut,
                        builder: (context, animatedValue, child) {
                          return SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(
                              value: animatedValue,
                              strokeWidth: 9,
                              backgroundColor: Colors.white24,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.tealAccent,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Text('Streak: ${habit.streak}', style: h2),
                    ],
                  ),

                  const SizedBox(width: 5),

                  const VerticalDivider(
                    color: Colors.white24,
                    thickness: 2,
                    width: 20,
                  ),

                  Text(habit.name, style: h1.copyWith(fontSize: 30)),
                  const Spacer(),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Checkbox(
                      activeColor: darkColor,
                      side: const BorderSide(
                        color: Color.fromARGB(255, 187, 238, 245),
                        width: 2,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // ListTile(
        //   leading: TweenAnimationBuilder<double>(
        //     tween: Tween<double>(begin: 0, end: progress),
        //     duration: const Duration(seconds: 1),
        //     curve: Curves.easeOut,
        //     builder: (context, animatedValue, child) {
        //       return SizedBox(
        //         height: 40,
        //         width: 40,
        //         child: CircularProgressIndicator(
        //           value: animatedValue,
        //           strokeWidth: 9,
        //           backgroundColor: Colors.white24,
        //           valueColor: const AlwaysStoppedAnimation<Color>(
        //             Colors.tealAccent,
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        //   title: Text(habit.name, style: h1.copyWith(fontSize: 30)),

        //   subtitle: Text('Score: ${habit.streak}', style: h2),

        //   trailing: SizedBox(
        //     height: 30,
        //     width: 30,
        //     child: Checkbox(
        //       activeColor: darkColor,
        //       side: const BorderSide(
        //         color: Color.fromARGB(255, 187, 238, 245),
        //         width: 2,
        //       ),
        //       value: habit.isChecked,
        //       onChanged: (value) {
        //         if (value != null) {
        //           ref
        //               .read(habitsListProvider.notifier)
        //               .toggleCheck(habit.id, value);
        //           if (value == true) {
        //             ref
        //                 .read(habitsListProvider.notifier)
        //                 .incrementStreak(habit.id);
        //           }
        //         }
        //       },
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

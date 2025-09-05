import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Habit_Goals_Tracker/models/habit.dart';

final authStateProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);

final habitsStreamProvider = StreamProvider<List<Habit>>((ref) {
  final auth = ref.watch(authStateProvider);
  // If auth not ready => empty stream
  if (auth.asData?.value == null) return const Stream.empty();

  final uid = auth.asData!.value!.uid;
  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('habits')
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          final categoryName = data['Category'] as String? ?? '';
          final categoryObj = categories.values.firstWhere(
            (c) => c.categoryName == categoryName,
            orElse: () => CCategory(
              icon: Icon(Icons.help),
              categoryName: 'Other',
              color: Colors.grey,
              gradient: LinearGradient(
                colors: [Color(0xFF0A344D), Color(0xFF1D6C8B)],
              ),
            ),
          );
          return Habit(
            id: doc.id,
            name: data['Name'] ?? '',
            description: data['Desc'] ?? '',
            goal: data['Goal'] ?? 0,
            category: categoryObj,
            streak: data['Streak'] ?? 0,
            isChecked: data['IsChecked'] ?? false,
          );
        }).toList();
      });
});

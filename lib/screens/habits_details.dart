import 'package:Habit_Goals_Tracker/basic.dart';
import 'package:Habit_Goals_Tracker/models/habit.dart';
import 'package:Habit_Goals_Tracker/providers/habit_stream.dart';
import 'package:Habit_Goals_Tracker/widgets/habits_with_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HabitsDetailsScreen extends ConsumerStatefulWidget {
  const HabitsDetailsScreen({super.key});

  @override
  ConsumerState<HabitsDetailsScreen> createState() =>
      _HabitsDetailsScreenState();
}

class _HabitsDetailsScreenState extends ConsumerState<HabitsDetailsScreen> {
  final categoryNames = categories.values.map((e) => e.categoryName).toList();
  final categoryColors = categories.values.map((e) => e.color).toList();
  @override
  Widget build(BuildContext context) {
    final habitsAsync = ref.watch(habitsStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Habits Manager',
          style: h1.copyWith(fontSize: 30),
          textAlign: TextAlign.center,
        ),
        backgroundColor: darkColor,
      ),

      body: habitsAsync.when(
        data: (habits) {
          return ListView.builder(
            itemCount: categoryNames.length,
            itemBuilder: (context, index) {
              return HabitsWithCategory(
                categoryName: categoryNames[index],
                categoryColor: categoryColors[index],
                habits: habits,
              );
            },
          );
        },
        error: (error, stackTrace) => Text('$error'),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}

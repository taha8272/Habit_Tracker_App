import 'package:Habit_Goals_Tracker/basic.dart';
import 'package:Habit_Goals_Tracker/models/habit.dart';
import 'package:Habit_Goals_Tracker/widgets/habit_detail_card.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HabitsWithCategory extends StatelessWidget {
  const HabitsWithCategory({
    super.key,
    required this.categoryName,
    required this.habits,
    required this.categoryColor,
  });
  final String categoryName;
  final List<Habit> habits;
  final Color categoryColor;

  Widget build(BuildContext context) {
    @override
    final habitsOfCategory = habits
        .where((element) => element.category.categoryName == categoryName)
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$categoryName', style: h1.copyWith(color: categoryColor)),
          if (habitsOfCategory.isEmpty)
            Text(
              'No habits of this category',
              style: h2.copyWith(color: darkColor),
            )
          else
            ...habitsOfCategory.map((e) => HabitDetailCard(habit: e)),
        ],
      ),
    );
  }
}

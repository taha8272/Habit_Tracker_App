import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitLeaderboard extends StatelessWidget {
  final List<Habit> habits;

  const HabitLeaderboard({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    // Sort habits by streak descending
    final sortedHabits = [...habits]
      ..sort((a, b) => b.streak.compareTo(a.streak));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Habit Leaderboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: sortedHabits.length,
        itemBuilder: (context, index) {
          final habit = sortedHabits[index];
          final rank = index + 1;

          // Decide medal/trophy icon
          IconData icon;
          Color color;
          switch (rank) {
            case 1:
              icon = Icons.emoji_events; // 🏆
              color = Colors.amber;
              break;
            case 2:
              icon = Icons.emoji_events;
              color = Colors.grey;
              break;
            case 3:
              icon = Icons.emoji_events;
              color = Colors.brown;
              break;
            default:
              icon = Icons.emoji_events_outlined;
              color = Colors.blueGrey;
          }

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(icon, color: color, size: rank == 1 ? 40 : 28),
              title: Text(
                habit.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${habit.streak} days streak"),
              trailing: Text(
                "#$rank",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 15,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

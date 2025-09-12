import 'package:Habit_Goals_Tracker/basic.dart';
import 'package:Habit_Goals_Tracker/providers/habit_stream.dart';
import 'package:Habit_Goals_Tracker/widgets/bar.dart';
import 'package:Habit_Goals_Tracker/widgets/drawer.dart';
import 'package:Habit_Goals_Tracker/widgets/habit_tile.dart';
import 'package:Habit_Goals_Tracker/widgets/leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HabitsListScreen extends ConsumerStatefulWidget {
  const HabitsListScreen({super.key});

  @override
  ConsumerState<HabitsListScreen> createState() => _HabitsListState();
}

class _HabitsListState extends ConsumerState<HabitsListScreen> {
  @override
  String? selectedOption = 'Change Display';

  List<String> options = [
    'Change Display',
    'Show Circular progress Bar',
    'Show Habit leaderboard',
  ];

  Widget build(BuildContext context) {
    final habitsAsync = ref.watch(habitsStreamProvider);
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: lightColor,
        title: ElevatedButton(
          onPressed: () {},

          style: ElevatedButton.styleFrom(backgroundColor: darkColor),
          child: Text('Routine Buddy', style: h1),
        ),

        centerTitle: true,
      ),

      drawer: DrawerWidget(),

      body: SafeArea(
        child: habitsAsync.when(
          data: (habits) {
            if (habits.isEmpty) {
              return const Center(child: Text('No habits yet.'));
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      DateFormat('EEEE, dd MMM yyyy').format(DateTime.now()),
                      style: h1.copyWith(fontSize: 20, color: darkColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 8,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: lightColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: darkColor, width: 1),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedOption,
                        items: options.map((String e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedOption = value;
                          });
                        },
                        dropdownColor: lightColor,
                        style: text,
                        iconEnabledColor: Colors.white,
                      ),
                    ),
                  ),
                ),

                if (selectedOption == 'Show Habit leaderboard')
                  Expanded(child: HabitLeaderboard(habits: habits)),

                if (selectedOption == 'Show Circular progress Bar')
                  RadialHabitsChart(habits: habits),

                Expanded(
                  child: ListView.builder(
                    itemCount: habits.length,
                    itemBuilder: (context, index) {
                      final habit = habits[index];
                      return HabitTile(habit: habit);
                    },
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}

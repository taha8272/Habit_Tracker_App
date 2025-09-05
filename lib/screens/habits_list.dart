import 'package:Habit_Goals_Tracker/basic.dart';
import 'package:Habit_Goals_Tracker/providers/habit_stream.dart';
import 'package:Habit_Goals_Tracker/widgets/bar.dart';
import 'package:Habit_Goals_Tracker/widgets/drawer.dart';
import 'package:Habit_Goals_Tracker/widgets/habit_tile.dart';
import 'package:Habit_Goals_Tracker/widgets/leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HabitsListScreen extends ConsumerStatefulWidget {
  const HabitsListScreen({super.key});

  @override
  ConsumerState<HabitsListScreen> createState() => _HabitsListState();
}

class _HabitsListState extends ConsumerState<HabitsListScreen> {
  @override
  String? selectedOption = 'No Display';

  List<String> options = [
    'No Display',
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
          child: Text('Habit Tracker', style: h1),
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
                  padding: const EdgeInsets.only(top: 10, bottom: 30, left: 10),
                  child: Align(
                    alignment:
                        Alignment.centerLeft, // <-- fixed (remove Geometry)
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ), // control size
                      decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isDense: true, // makes it tighter
                          style: text,
                          dropdownColor: lightColor,
                          borderRadius: BorderRadius.circular(14),
                          iconEnabledColor: Colors.white,
                          iconDisabledColor: Colors.white,
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
                        ),
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

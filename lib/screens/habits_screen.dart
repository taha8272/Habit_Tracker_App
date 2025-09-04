import 'package:car_rental/basic.dart';
import 'package:car_rental/data/dummy_data.dart';
import 'package:car_rental/models/habit.dart';
import 'package:car_rental/providers/habit_stream.dart';
import 'package:car_rental/screens/add_new_habit.dart';
import 'package:car_rental/widgets/bar.dart';
import 'package:car_rental/widgets/drawer.dart';

import 'package:car_rental/widgets/habit_tile.dart';
import 'package:car_rental/widgets/leaderboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_rental/providers/habits_list_provider.dart';
import 'dart:math' as math;

class HabitsScreen extends ConsumerStatefulWidget {
  const HabitsScreen({super.key});

  @override
  ConsumerState<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends ConsumerState<HabitsScreen> {
  int selectedPageIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void showModalOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => AddNewHabitScreen(),
    );
  }

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
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 63),
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Habit Tracker', style: text),
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1D6C8B)),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              icon: Icon(
                Icons.home,
                color: selectedPageIndex == 0 ? lightColor : Colors.grey,
              ),
              label: Text('Today'),
              onPressed: () => onItemTapped(0),
            ),

            SizedBox(width: 40), // space for FAB in middle

            ElevatedButton(
              onPressed: showModalOverlay,

              style: ElevatedButton.styleFrom(backgroundColor: darkColor),
              child: Icon(Icons.add, color: colortext, size: 25),
            ),

            SizedBox(width: 40),

            TextButton.icon(
              icon: Icon(
                Icons.person,
                color: selectedPageIndex == 1 ? lightColor : Colors.grey,
              ),
              label: Text('Habit'),
              onPressed: () => onItemTapped(1),
            ),
          ],
        ),
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
                  RotatingHabitsChart(habits: habits),

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

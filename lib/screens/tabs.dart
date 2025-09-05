import 'package:Habit_Goals_Tracker/basic.dart';
import 'package:Habit_Goals_Tracker/screens/add_new_habit.dart';
import 'package:Habit_Goals_Tracker/screens/habits_details.dart';
import 'package:Habit_Goals_Tracker/screens/habits_list.dart';
import 'package:flutter/material.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
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
      builder: (context) => const AddNewHabitScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: showModalOverlay,
        backgroundColor: darkColor,
        elevation: 4,
        child: const Icon(Icons.add, size: 28, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        height: 64, // tighter height
        color: lightColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Today tab
              InkWell(
                onTap: () => onItemTapped(0),
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 56, // fixes overflow
                  width: 64,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 24,
                        color: selectedPageIndex == 0
                            ? darkColor
                            : Colors.white,
                      ),
                      Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 11,

                          fontWeight: selectedPageIndex == 0
                              ? FontWeight.bold
                              : FontWeight.bold,
                          color: selectedPageIndex == 0
                              ? darkColor
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Spacer for FAB
              const SizedBox(width: 48),

              // Habits tab
              InkWell(
                onTap: () => onItemTapped(1),
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 56, // fixes overflow
                  width: 64,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.list_alt_rounded,
                        size: 24,
                        color: selectedPageIndex == 1
                            ? darkColor
                            : Colors.white,
                      ),
                      Text(
                        'Habits',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: selectedPageIndex == 1
                              ? FontWeight.bold
                              : FontWeight.bold,
                          color: selectedPageIndex == 1
                              ? darkColor
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: selectedPageIndex == 0
          ? const HabitsListScreen()
          : const HabitsDetailsScreen(),
    );
  }
}

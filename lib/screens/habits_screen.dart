import 'package:car_rental/basic.dart';
import 'package:car_rental/data/dummy_data.dart';
import 'package:car_rental/models/habit.dart';
import 'package:car_rental/providers/habit_stream.dart';
import 'package:car_rental/screens/add_new_habit.dart';
import 'package:car_rental/widgets/habit_tile.dart';
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

      drawer: Drawer(
        backgroundColor: Color(0xFF0A344D),

        child: Column(
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0A344D), Color(0xFF1D6C8B)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                border: Border.all(width: 0),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.run_circle_outlined,
                    color: const Color.fromARGB(255, 187, 238, 245),
                    size: 45,
                  ),
                  const SizedBox(width: 15),
                  Text('Habit Tracker', style: h1),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.home,
                      color: const Color.fromARGB(255, 187, 238, 245),
                      size: 25,
                    ),
                    title: Text('Home', style: h2),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.settings,
                      color: const Color.fromARGB(255, 187, 238, 245),
                      size: 25,
                    ),
                    title: Text('Settings', style: h2),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.support_agent_sharp,
                      color: const Color.fromARGB(255, 187, 238, 245),
                      size: 25,
                    ),
                    title: Text('Suggestions', style: h2),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.stars,
                      color: const Color.fromARGB(255, 187, 238, 245),
                      size: 25,
                    ),
                    title: Text('Rate this app', style: h2),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.share,
                      color: const Color.fromARGB(255, 187, 238, 245),
                      size: 25,
                    ),
                    title: Text('Share this app', style: h2),
                    onTap: () {},
                  ),
                  Divider(
                    color: Colors.white24,
                    thickness: 1,
                    indent: 8,
                    endIndent: 8,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.logout,
                      color: const Color.fromARGB(255, 187, 238, 245),
                      size: 25,
                    ),
                    title: Text('Sign out', style: h2),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: lightColor,
                          title: Text('Log out', style: h1),
                          content: Text(
                            'Are you sure you wanna log out, you will have to enter your credentials to log in again',
                            style: text,
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colortext,
                                foregroundColor: darkColor,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                FirebaseAuth.instance.signOut();
                              },
                              child: Text('Log out'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: lightColor,
                                foregroundColor: colortext,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: habitsAsync.when(
          data: (habits) {
            if (habits.isEmpty) {
              return const Center(child: Text('No habits yet.'));
            }
            return ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                final habit = habits[index];
                return HabitTile(habit: habit);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}

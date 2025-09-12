import 'package:Habit_Goals_Tracker/basic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF0A344D),
      child: SafeArea(
        top: true,
        bottom: false,
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
                  Text('Settings', style: h1),
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
                      Icons.ac_unit_sharp,
                      color: const Color.fromARGB(255, 187, 238, 245),
                      size: 25,
                    ),
                    title: Text('Track Habits', style: h2),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.border_all_rounded,
                      color: const Color.fromARGB(255, 187, 238, 245),
                      size: 25,
                    ),
                    title: Text('Leaderboard', style: h2),
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
    );
  }
}

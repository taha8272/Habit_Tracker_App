import 'package:car_rental/basic.dart';
import 'package:car_rental/models/category.dart';
import 'package:car_rental/models/habit.dart';
import 'package:car_rental/providers/habits_list_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_rental/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewHabitScreen extends ConsumerStatefulWidget {
  const AddNewHabitScreen({super.key});

  @override
  ConsumerState<AddNewHabitScreen> createState() => _AddNewHabitScreenState();
}

class _AddNewHabitScreenState extends ConsumerState<AddNewHabitScreen> {
  final formKey = GlobalKey<FormState>();
  var selectedName;
  var selectedDescription;
  final categoriesList = categories.values.toList();
  int currentIndex = 0;
  void onSaved() async {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();
    final selectedCategory = categoriesList[currentIndex];

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('habits')
        .doc(); // auto-generated ID

    try {
      await docRef.set({
        'Name': selectedName,
        'Desc': selectedDescription,
        'Category': selectedCategory.categoryName,
        'Streak': 0,
        'IsChecked': false,
      });
      Navigator.pop(context); // close modal only once
    } catch (e) {
      print('Error adding habit: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onSaved,
        label: Text(
          'Save Habit',
          style: text.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 8, 43, 63),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(7),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A344D), Color(0xFF1D6C8B)],
            begin: AlignmentGeometry.bottomCenter,
            end: AlignmentGeometry.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 80,
            bottom: 30,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Text('Add New Habit', style: h1),
              const SizedBox(height: 60),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('Habit Name', style: h2),
                        prefixIcon: Icon(
                          Icons.sports_handball_outlined,
                          color: Colors.white70,
                        ),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      autocorrect: false,
                      style: text,
                      maxLength: 25,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length < 1) {
                          return 'Enter Habit Name';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        selectedName = newValue;
                      },
                    ),
                    const SizedBox(height: 20),

                    Text('Select Category: ', style: h2),

                    const SizedBox(height: 20),

                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: categoriesList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        final category = categoriesList[index];
                        final isSelected = currentIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? darkColor.withValues(alpha: 0.2)
                                  : Colors.white,
                              // border: Border.all(
                              //   color: isSelected
                              //       ? Colors.blue
                              //       : Colors.transparent,
                              //   width: 2,
                              // ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                category.icon,
                                Text(
                                  category.categoryName,
                                  style: text.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 80),
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('Description', style: h2),
                        prefixIcon: Icon(
                          Icons.edit_document,
                          color: Colors.white70,
                        ),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      maxLength: 100,
                      autocorrect: false,
                      style: text,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length < 1) {
                          return 'Enter Description';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        selectedDescription = newValue;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

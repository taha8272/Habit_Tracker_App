import 'package:Habit_Goals_Tracker/basic.dart';
import 'package:Habit_Goals_Tracker/models/category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum Goal {
  oneWeek("One Week", 7),
  oneMonth("One Month", 30),
  twoMonth("Two Month", 60),
  threeMonth("Three Month", 90),
  fourMonth("Four Month", 120),
  oneYear("One Year", 365);

  final String label;
  final int days;
  const Goal(this.label, this.days);
}

final uuid = Uuid();

class Habit {
  final String id;
  final String name;
  final String description;
  final int streak;
  final bool isChecked;
  final CCategory category;
  final int goal;
  Habit({
    String? id, //make sit optional
    required this.name,
    required this.description,
    required this.category,
    required this.goal,
    this.streak = 0,
    this.isChecked = false,
  }) : id = id ?? uuid.v4();

  Habit copyWith({
    String? id,
    String? name,
    String? description,
    CCategory? category,
    int? goal,
    int? streak,
    bool? isChecked,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      goal: goal ?? this.goal,
      streak: streak ?? this.streak,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}

enum Categories {
  health,
  productive,
  learning,
  mentalHealth,
  social,
  finance,
  creative,
  spirituality,
}

class CCategory {
  const CCategory({
    required this.icon,
    required this.categoryName,
    required this.color,
    required this.gradient,
  });
  final Icon icon;
  final String categoryName;
  final Color color;
  final Gradient gradient;
}

var categories = {
  Categories.health: CCategory(
    icon: Icon(Icons.fitness_center, color: Color(0xFFE53935)),
    categoryName: 'Health',
    color: Color(0xFFE53935),
    gradient: LinearGradient(
      colors: [Color(0xFFE53935), Color(0xFFEF5350)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  Categories.productive: CCategory(
    icon: Icon(Icons.work, color: darkColor),
    categoryName: 'Productive',
    color: darkColor,
    gradient: LinearGradient(
      colors: [darkColor, lightColor],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  Categories.learning: CCategory(
    icon: Icon(Icons.school, color: Color(0xFF1E88E5)),
    categoryName: 'Learning',
    color: Color(0xFF1E88E5),
    gradient: LinearGradient(
      colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  Categories.mentalHealth: CCategory(
    icon: Icon(Icons.self_improvement, color: Color(0xFF8E24AA)),
    categoryName: 'Mental Health',
    color: Color(0xFF8E24AA),
    gradient: LinearGradient(
      colors: [Color(0xFF8E24AA), Color(0xFFAB47BC)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  Categories.social: CCategory(
    icon: Icon(Icons.people, color: Color(0xFFFB8C00)),
    categoryName: 'Social',
    color: Color(0xFFFB8C00),
    gradient: LinearGradient(
      colors: [Color(0xFFFB8C00), Color(0xFFFFB74D)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  Categories.finance: CCategory(
    icon: Icon(Icons.attach_money, color: Color(0xFF43A047)),
    categoryName: 'Finance',
    color: Color(0xFF43A047),
    gradient: LinearGradient(
      colors: [Color(0xFF43A047), Color(0xFF66BB6A)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  Categories.creative: CCategory(
    icon: Icon(Icons.brush, color: Color(0xFF00ACC1)),
    categoryName: 'Creative',
    color: Color(0xFF00ACC1),
    gradient: LinearGradient(
      colors: [Color(0xFF00ACC1), Color(0xFF26C6DA)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  Categories.spirituality: CCategory(
    icon: Icon(Icons.star, color: Color(0xFFFDD835)),
    categoryName: 'Spirituality',
    color: Color(0xFFFDD835),
    gradient: LinearGradient(
      colors: [Color(0xFFFDD835), Color(0xFFFFEE58)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
};

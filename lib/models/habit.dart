import 'package:car_rental/models/category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Habit {
  final String id;
  final String name;
  final String description;
  final int streak;
  final bool isChecked;
  final CCategory category;

  Habit({
    String? id, //make sit optional
    required this.name,
    required this.description,
    required this.category,
    this.streak = 0,
    this.isChecked = false,
  }) : id = id ?? uuid.v4();

  Habit copyWith({
    String? id,
    String? name,
    String? description,
    CCategory? category,
    int? streak,
    bool? isChecked,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      streak: streak ?? this.streak,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}

enum Categories {
  health,
  productivity,
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
  });
  final Icon icon;
  final String categoryName;
  final Color color;
}

var categories = {
  Categories.health: CCategory(
    icon: Icon(Icons.fitness_center, color: Color(0xFFE53935)),
    categoryName: 'Health',
    color: Color(0xFFE53935),
  ),
  Categories.productivity: CCategory(
    icon: Icon(Icons.work, color: Color(0xFF3949AB)),
    categoryName: 'Productivity',
    color: Color(0xFF3949AB),
  ),
  Categories.learning: CCategory(
    icon: Icon(Icons.school, color: Color(0xFF1E88E5)),
    categoryName: 'Learning',
    color: Color(0xFF1E88E5),
  ),
  Categories.mentalHealth: CCategory(
    icon: Icon(Icons.self_improvement, color: Color(0xFF8E24AA)),
    categoryName: 'Mental Health',
    color: Color(0xFF8E24AA),
  ),
  Categories.social: CCategory(
    icon: Icon(Icons.people, color: Color(0xFFFB8C00)),
    categoryName: 'Social',
    color: Color(0xFFFB8C00),
  ),
  Categories.finance: CCategory(
    icon: Icon(Icons.attach_money, color: Color(0xFF43A047)),
    categoryName: 'Finance',
    color: Color(0xFF43A047),
  ),
  Categories.creative: CCategory(
    icon: Icon(Icons.brush, color: Color(0xFF00ACC1)),
    categoryName: 'Creative',
    color: Color(0xFF00ACC1),
  ),
  Categories.spirituality: CCategory(
    icon: Icon(Icons.star, color: Color(0xFFFDD835)),
    categoryName: 'Spirituality',
    color: Color(0xFFFDD835),
  ),
};

// import 'package:car_rental/models/habit.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:car_rental/models/habit.dart';

// class HabitsListNotifier extends StateNotifier<List<Habit>> {
//   HabitsListNotifier() : super(const []);

//   void addHabit(Habit newHabit) {
//     state = [...state, newHabit];
//   }

//   void incrementStreak(String id) {
//     state = state
//         .map(
//           (habit) =>
//               habit.id == id ? habit.copyWith(streak: habit.streak + 1) : habit,
//         )
//         .toList();
//   }

//   void toggleCheck(String id, bool value) {
//     state = state
//         .map(
//           (habit) => habit.id == id ? habit.copyWith(isChecked: value) : habit,
//         )
//         .toList();
//   }
// }

// final habitsListProvider =
//     StateNotifierProvider<HabitsListNotifier, List<Habit>>(
//       (ref) => HabitsListNotifier(),
//     );

import 'package:my_learning/pantry/models/meal/meal_model.dart';
import 'package:my_learning/pantry/models/meal_time_enum.dart';
import 'package:uuid/uuid.dart';

import 'meal_prep_enum.dart';

class ScheduledMeal {
  final String id;
  final Meal meal;
  final MealTime mealTime;
  final DateTime date;
  final DateTime timeStamp;
  final int servings;
  final String? note;
  final MealPrep? mealPrep;

  ScheduledMeal({
    String? id,
    required this.meal,
    required this.mealTime,
    required this.date,
    required this.timeStamp,
    required this.servings,
    required this.note,
    this.mealPrep,
  }) : id = id ?? const Uuid().v4();

  ScheduledMeal copyWith({
    String? id,
    Meal? meal,
    MealTime? mealTime,
    DateTime? date,
    DateTime? timeStamp,
    int? servings,
    String? note,
    MealPrep? mealPrep,
}) {
    return ScheduledMeal(
      id: id ?? this.id,
      meal: meal ?? this.meal,
      mealTime: mealTime ?? this.mealTime,
      date: date ?? this.date,
      timeStamp: timeStamp ?? this.timeStamp,
      servings: servings ?? this.servings,
      note: note ?? this.note,
      mealPrep: mealPrep ?? this.mealPrep,
    );
  }
  factory ScheduledMeal.fromJson(Map<String, dynamic> json) => ScheduledMeal(
    id: json['id'] as String,
    meal: Meal.fromJson(json['meal'] as Map<String, dynamic>),
    mealTime: MealTime.values.firstWhere((m) => m.name == json['mealTime']),
    date: DateTime.parse(json['date'] as String),
    timeStamp: DateTime.parse(json['timeStamp'] as String),
    servings: (json['servings'] as num).toInt(),
    note: json['note'] as String?,
    mealPrep: MealPrep.values.firstWhere((p) => p.name == json['mealPrep']),
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meal': meal.toJson(),
      'mealTime': mealTime.toString().split('.').last,
      'date': date.toIso8601String(),
      'timeStamp': timeStamp.toIso8601String(),
      'servings': servings,
      'note': note,
      'mealPrep': mealPrep.toString().split('.').last,
    };
  }
}



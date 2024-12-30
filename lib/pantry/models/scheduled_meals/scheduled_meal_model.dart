import 'package:my_learning/pantry/models/meal/meal_model.dart';
import 'package:my_learning/pantry/models/meal_time_enum.dart';
import 'package:uuid/uuid.dart';

class ScheduledMeal {
  final String id;
  final Meal meal;
  final MealTime mealTime;
  final DateTime date;
  final int servings;
  final String? note;

  ScheduledMeal({
    String? id,
    required this.meal,
    required this.mealTime,
    required this.date,
    required this.servings,
    required this.note,
  }) : id = id ?? const Uuid().v4();

  ScheduledMeal copyWith({
    String? id,
    Meal? meal,
    MealTime? mealTime,
    DateTime? date,
    int? servings,
    String? note,
}) {
    return ScheduledMeal(
      id: id ?? this.id,
      meal: meal ?? this.meal,
      mealTime: mealTime ?? this.mealTime,
      date: date ?? this.date,
      servings: servings ?? this.servings,
      note: note ?? this.note,
    );
  }
  factory ScheduledMeal.fromJson(Map<String, dynamic> json) => ScheduledMeal(
    id: json['id'] as String,
    meal: Meal.fromJson(json['meal'] as Map<String, dynamic>),
    mealTime: MealTime.values.firstWhere((m) => m.name == json['mealTime']),
    date: DateTime.parse(json['date'] as String),
    servings: (json['servings'] as num).toInt(),
    note: json['note'] as String?,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meal': meal.toJson(),
      'mealTime': mealTime.toString().split('.').last,
      'date': date.toIso8601String(),
      'servings': servings,
      'note': note,
    };
  }
}



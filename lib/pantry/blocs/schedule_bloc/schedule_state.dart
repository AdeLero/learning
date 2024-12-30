part of 'schedule_bloc.dart';

@immutable
sealed class ScheduleState {}

final class ScheduleInitial extends ScheduleState {}

class ScheduleBeingFilled extends ScheduleState {
  final MealTime? mealTime;
  final Meal? meal;
  final DateTime? date;
  final int servings;

  ScheduleBeingFilled({
    this.mealTime,
    this.meal,
    this.date,
    this.servings = 1,
  });

  ScheduleBeingFilled copyWith({
    MealTime? mealTime,
    Meal? meal,
    DateTime? date,
    int? servings,
  }) {
    return ScheduleBeingFilled(
      mealTime: mealTime ?? this.mealTime,
      meal: meal ?? this.meal,
      date: date ?? this.date,
      servings: servings ?? this.servings,
    );
  }
}

class ScheduledMealComplete extends ScheduleState {
  final List<ScheduledMeal> scheduledMeals;

  ScheduledMealComplete({required this.scheduledMeals});
}

class ScheduleError extends ScheduleState {
  final String message;

  ScheduleError({required this.message});
}

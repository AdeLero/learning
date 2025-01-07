part of 'meal_time_bloc.dart';

@immutable
sealed class MealTimeEvent {}

class UpdateMealTime extends MealTimeEvent {
  final MealTime mealTime;
  final TimeOfDay time;

  UpdateMealTime({
    required this.mealTime,
    required this.time,
  });
}

class ChangeMealTimes extends MealTimeEvent {
  final List<MealTimeSetting> mealTimes;

  ChangeMealTimes({required this.mealTimes});
}

class StartCountdown extends MealTimeEvent {
  final MealTime mealTime;

  StartCountdown({required this.mealTime});
}

class OpenSettings extends MealTimeEvent {}

class CloseSettings extends MealTimeEvent {}

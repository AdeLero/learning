part of 'meal_time_bloc.dart';

@immutable
sealed class MealTimeState {}

final class MealTimeInitial extends MealTimeState {}

class MealTimeUpdated extends MealTimeState {
  final List<MealTimeSetting> mealTimes;

  MealTimeUpdated({required this.mealTimes});
}

class CountingDown extends MealTimeState {
  final Duration timeRemaining;
  final MealTime mealTime;

  CountingDown({required this.timeRemaining, required this.mealTime,});
}


class MealTimeUpdateError extends MealTimeState {
  final String message;

  MealTimeUpdateError({required this.message});
}



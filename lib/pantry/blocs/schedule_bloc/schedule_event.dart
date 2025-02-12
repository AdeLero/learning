part of 'schedule_bloc.dart';

@immutable
sealed class ScheduleEvent {}

class NavigateScheduleBack extends ScheduleEvent {}

class GetMealTime extends ScheduleEvent {
  final MealTime mealTime;

  GetMealTime({
    required this.mealTime,
  });
}

class GetMeal extends ScheduleEvent {
  final Meal meal;

  GetMeal({required this.meal});
}

class UpdateSchedule extends ScheduleEvent {
  final List<ScheduledMeal> scheduledMeals;

  UpdateSchedule({required this.scheduledMeals});
}

class DeletePendingMeal extends ScheduleEvent {}

class GetDate extends ScheduleEvent {
  final DateTime date;

  GetDate({required this.date});
}

class UpdateServings extends ScheduleEvent {
  final int servings;

  UpdateServings({required this.servings});
}

class AddScheduledMeal extends ScheduleEvent {
  final MealTime mealTime;
  final Meal meal;
  final DateTime date;
  final int servings;

  AddScheduledMeal({
    required this.mealTime,
    required this.meal,
    required this.date,
    required this.servings,
  });
}

class EditAScheduledMeal extends ScheduleEvent {
  final String id;
  final MealTime mealTime;
  final Meal meal;
  final DateTime date;
  final int servings;
  final MealPrep? mealPrep;

  EditAScheduledMeal({
    required this.id,
    required this.mealTime,
    required this.meal,
    required this.date,
    required this.servings,
    this.mealPrep,
  });
}

class CookedMeal extends ScheduleEvent {
  final String id;

  CookedMeal({required this.id});
}

class OrderedMeal extends ScheduleEvent {
  final String id;

  OrderedMeal({required this.id});
}

class ClearMealPrep extends ScheduleEvent {
  final String id;

  ClearMealPrep({required this.id});
}

class DeleteMealFromSchedule extends ScheduleEvent {
  final String id;

  DeleteMealFromSchedule({required this.id});
}

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_learning/pantry/models/meal/meal_model.dart';
import 'package:my_learning/pantry/models/meal_time_enum.dart';
import 'package:my_learning/pantry/models/scheduled_meals/scheduled_meal_model.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends HydratedBloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleInitial()) {
    on<NavigateScheduleBack>(navigateBack);
    on<GetMealTime>(getMealTime);
    on<GetMeal>(getMeal);
    on<DeletePendingMeal>(deleteMeal);
    on<GetDate>(getDate);
    on<UpdateServings>(updateServings);
    on<AddScheduledMeal>(addScheduledMeal);
    on<EditAScheduledMeal>(editAScheduledMeal);
    on<DeleteMealFromSchedule>(deleteMealFromSchedule);
  }

  MealTime? draftMealTime = MealTime.breakfast;
  Meal? draftMeal;
  DateTime? draftDate = DateTime.now();
  List<ScheduledMeal> scheduledMeals = [];

  void navigateBack(NavigateScheduleBack event, Emitter<ScheduleState> emit) {
    emit(ScheduledMealComplete(scheduledMeals: scheduledMeals));
  }

  void getMealTime(GetMealTime event, Emitter<ScheduleState> emit) {
    draftMealTime = event.mealTime;

    final currentState = state;

    if (currentState is ScheduleBeingFilled) {
      emit(currentState.copyWith(mealTime: draftMealTime));
    } else {
      emit(ScheduleBeingFilled(mealTime: draftMealTime));
    }
  }

  void getMeal(GetMeal event, Emitter<ScheduleState> emit) {
    draftMeal = event.meal;

    final currentState = state;

    if (currentState is ScheduleBeingFilled) {
      emit(currentState.copyWith(meal: draftMeal));
    } else {
      emit(ScheduleBeingFilled(meal: draftMeal));
    }
  }

  void deleteMeal(DeletePendingMeal event, Emitter<ScheduleState> emit) {
    if (draftMeal != null) {
      draftMeal = null;
    }

    final currentState = state;
    if (currentState is ScheduleBeingFilled) {
      emit(ScheduleBeingFilled(
        meal: null,
        mealTime: draftMealTime,
        date: draftDate,
      ));
    } else {
      emit(ScheduleBeingFilled(meal: null));
    }
  }

  void getDate(GetDate event, Emitter<ScheduleState> emit) {
    draftDate = event.date;

    final currentState = state;
    if (currentState is ScheduleBeingFilled) {
      emit(currentState.copyWith(date: draftDate));
    } else {
      emit(ScheduleBeingFilled(date: draftDate));
    }
  }

  void updateServings(UpdateServings event, Emitter<ScheduleState> emit) {
    final currentState = state;

    final updatedServings = event.servings > 0 ? event.servings : 1;

    if (currentState is ScheduleBeingFilled) {
      emit(currentState.copyWith(servings: updatedServings));
    } else {
      emit(ScheduleBeingFilled(servings: updatedServings));
    }
  }

  void addScheduledMeal(AddScheduledMeal event, Emitter<ScheduleState> emit) {
    try{
      scheduledMeals.add(ScheduledMeal(meal: event.meal,
          mealTime: event.mealTime,
          date: event.date,
          servings: event.servings,
          note: "",));

      draftMealTime = null;
      draftMeal = null;
      draftDate = null;

      emit(ScheduledMealComplete(scheduledMeals: scheduledMeals));
    } catch (e) {
      emit(ScheduleError(message: e.toString()));
    }
  }

  void editAScheduledMeal(EditAScheduledMeal event, Emitter<ScheduleState> emit) {
    try{
      final index = scheduledMeals.indexWhere((meal) => meal.id == event.id);

      if (index == -1){
        emit(ScheduleError(message: "Can't find Meal"));
      }

      scheduledMeals[index] = scheduledMeals[index].copyWith(
        mealTime: event.mealTime,
        meal: event.meal,
        date: event.date,
        servings: event.servings,
      );
      emit(ScheduledMealComplete(scheduledMeals: scheduledMeals));
    } catch (e) {
      emit(ScheduleError(message: e.toString()));
    }
  }

  void deleteMealFromSchedule(DeleteMealFromSchedule event, Emitter<ScheduleState> emit) {
    try {
      final index = scheduledMeals.indexWhere((meal) => meal.id == event.id);

      if (index == -1) {
        emit(ScheduleError(message: "Cant Find Scheduled Meal"));
      }
      scheduledMeals.removeAt(index);

      if (scheduledMeals.isEmpty) {
        emit(ScheduleInitial());
      } else {
        emit(ScheduledMealComplete(scheduledMeals: scheduledMeals));
      }
    } catch (e) {
      emit(ScheduleError(message: e.toString()));
    }
  }

  @override
  ScheduleState? fromJson(Map<String, dynamic> json) {
    try {
      if (json["scheduledMeals"] != null) {
        final scheduledMeals = (json["scheduledMeals"] as List)
            .map((scheduledMeal) => ScheduledMeal.fromJson(scheduledMeal as Map<String, dynamic>))
            .toList();

        return ScheduledMealComplete(scheduledMeals: scheduledMeals);
      } else if (json["error"] != null) {
        return ScheduleError(message: json["error"]);
      } else if (json["initial"] != null) {
        return ScheduleInitial();
      }
    } catch (e) {
      return ScheduleError(message: e.toString());
    }

    return ScheduleInitial();
  }

  @override
  Map<String, dynamic> toJson(ScheduleState state) {
    if (state is ScheduledMealComplete) {
      final scheduleJson = state.scheduledMeals.map(
          (scheduledMeal) => scheduledMeal.toJson()
      ).toList();

      return {"scheduledMeals": scheduleJson};
    } else if (state is ScheduleBeingFilled) {
      return {
        "mealTime": state.mealTime.toString().split('.').last,
        "meal": state.meal?.toJson(),
        "servings": state.servings,
        "date": state.date?.toIso8601String(),
      };
    } else if (state is ScheduleError) {
      return {"error": state.message};
    } else if (state is ScheduleInitial) {
      return {"initial": true};
    } else {
      throw UnimplementedError();
    }
  }
}

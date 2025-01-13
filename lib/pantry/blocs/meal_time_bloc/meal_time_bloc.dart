import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_learning/pantry/models/meal_time/meal_time_model.dart';
import 'package:my_learning/pantry/models/meal_time_enum.dart';

part 'meal_time_event.dart';
part 'meal_time_state.dart';



class MealTimeBloc extends HydratedBloc<MealTimeEvent, MealTimeState> {
  MealTimeBloc() : super(MealTimeInitial()) {
    on<UpdateMealTime>(updateMealTime);
    on<StartCountdown>(startCountdown);
    _startAutoCountdown();
    _onStart();
    on<OpenSettings>(openSettings);
    on<CloseSettings>(closeSettings);
  }

  List<MealTimeSetting> mealTimes = [
    MealTimeSetting(
        mealTime: MealTime.breakfast,
        time: const TimeOfDay(hour: 8, minute: 0)),
    MealTimeSetting(
        mealTime: MealTime.lunch, time: const TimeOfDay(hour: 14, minute: 0)),
    MealTimeSetting(
        mealTime: MealTime.dinner, time: const TimeOfDay(hour: 20, minute: 0)),
  ];

  Timer? _timer;

  final StreamController<Duration> _timerStreamController = StreamController<Duration>.broadcast();

  Stream<Duration> get timerStream => _timerStreamController.stream;

  void _onStart () {
    if (state is MealTimeInitial) {
      _startAutoCountdown();
    }
  }

  void updateMealTime(UpdateMealTime event, Emitter<MealTimeState> emit) {
    final index =
        mealTimes.indexWhere((time) => time.mealTime == event.mealTime);

    if (index == -1) {
      emit(MealTimeUpdateError(message: "Can't find Meal Time"));
      return;
    }

    mealTimes[index] = MealTimeSetting(
        mealTime: event.mealTime,
        time: TimeOfDay(
          hour: event.time.hour,
          minute: event.time.minute,
        ));

    emit(MealTimeUpdated(mealTimes: mealTimes));
    _startAutoCountdown();
  }

  void _startAutoCountdown() {
    if (state is MealTimeInitial) {
      final now = DateTime.now();

      final nextMealTime = mealTimes.firstWhere(
            (mealTime) {
          final mealDateTime = DateTime(
            now.year,
            now.month,
            now.day,
            mealTime.time.hour,
            mealTime.time.minute,
          );
          return mealDateTime.isAfter(now);
        },
        orElse: () {
          // Check if it's past dinner, then loop back to breakfast
          final nextMealIndex = (mealTimes.indexOf(mealTimes.firstWhere((mealTime) => mealTime.time.hour > now.hour)) + 1) % mealTimes.length;
          return mealTimes[nextMealIndex]; // Default to the next meal
        },
      );

      add(StartCountdown(mealTime: nextMealTime.mealTime)); // Trigger countdown event
    }
  }



  void startCountdown(StartCountdown event, Emitter<MealTimeState> emit) {
    print("Counting down");
    // if (_timer?.isActive ?? false) return;

    final mealTime = mealTimes.firstWhere(
          (time) => time.mealTime == event.mealTime,
      orElse: () => mealTimes.first,
    );

    DateTime now = DateTime.now();
    var timeRemaining = mealTime.getTimeRemaining(now, mealTimes);

    emit(CountingDown(timeRemaining: timeRemaining, mealTime: mealTime.mealTime));

    _timer?.cancel(); // Cancel any existing timer.

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (timeRemaining.inSeconds > 0) {
        timeRemaining -= const Duration(seconds: 1);
        _timerStreamController.add(timeRemaining);
      } else {
        _timer?.cancel(); // Stop the timer when time is up.

        // Start countdown for the next meal time.
        final nextMealTime = mealTimes.firstWhere(
              (x) => x.getTimeRemaining(DateTime.now(), mealTimes).inSeconds > 0,
          orElse: () => mealTimes.first,
        );
        add(StartCountdown(mealTime: nextMealTime.mealTime));
      }
    });
    emit(CountingDown(timeRemaining: timeRemaining, mealTime: mealTime.mealTime));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _timerStreamController.close();
    return super.close();
  }

  void openSettings(OpenSettings event, Emitter<MealTimeState> emit) {
    if (state is! MealTimeUpdated) {
      emit(MealTimeUpdated(mealTimes: mealTimes));
    }
  }

  void closeSettings(CloseSettings event, Emitter<MealTimeState> emit) {

    if (state is MealTimeUpdated) {
      emit(MealTimeInitial());
    }

    _startAutoCountdown();
  }

  @override
  MealTimeState? fromJson(Map<String, dynamic> json) {
    try {
      final mealTimesJson = json["mealTimes"] as List;
      final restoredMealTimes = mealTimesJson
      .map((mealTimeJson) => MealTimeSetting.fromJson(mealTimeJson))
      .toList();

      mealTimes = restoredMealTimes;

      final now = DateTime.now();
      final nextMealTime = mealTimes.firstWhere(
            (mealTime) {
          final mealDateTime = DateTime(
            now.year,
            now.month,
            now.day,
            mealTime.time.hour,
            mealTime.time.minute,
          );
          return mealDateTime.isAfter(now); // Look for the next meal time
        },
        orElse: () {

          final nextMealIndex = (mealTimes.indexOf(
              mealTimes.firstWhere((mealTime) => mealTime.time.hour > now.hour)) +
              1) %
              mealTimes.length;
          return mealTimes[nextMealIndex]; // Default to the next meal
        },
      );

      add(StartCountdown(mealTime: nextMealTime.mealTime));

      return MealTimeUpdated(mealTimes: mealTimes);
    } catch (e) {
      print(e.toString());
    }
    return MealTimeInitial();
  }

  @override
  Map<String, dynamic> toJson(MealTimeState state) {
    return {
      'mealTimes': mealTimes.map((mealTime) => mealTime.toJson()).toList(),
    };
  }
}

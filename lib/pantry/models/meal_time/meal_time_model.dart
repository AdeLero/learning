import 'package:flutter/material.dart';
import 'package:my_learning/pantry/models/meal_time_enum.dart';

class MealTimeSetting {
  final MealTime mealTime;
  final TimeOfDay time;

  MealTimeSetting({
    required this.mealTime,
    required this.time,
  });

  MealTimeSetting copyWith({
    MealTime? mealTime,
    TimeOfDay? time,
}) {
    return MealTimeSetting(
      mealTime: mealTime ?? this.mealTime,
      time: time ?? this.time,
    );
  }

  factory MealTimeSetting.fromJson(Map<String, dynamic> json) {
    return MealTimeSetting(
      mealTime: MealTime.values.firstWhere((m) => m.name == json["mealTime"] ),
      time: TimeOfDay(hour: json["hour"]!, minute: json["minute"]!),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mealTime": mealTime.toString().split('.').last,
      "hour": time.hour,
      "minute": time.minute,
    };
  }

  Duration getTimeRemaining(DateTime now, List<MealTimeSetting> mealTimes) {
    mealTimes.sort((a,b) {
      final aMinutes = a.time.hour * 60 + a.time.minute;
      final bMinutes = b.time.hour * 60 + b.time.minute;
      return aMinutes.compareTo(bMinutes);
    });

    for (final setting in mealTimes) {
      final DateTime mealDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        setting.time.hour,
        setting.time.minute,
      );

      if (mealDateTime.isAfter(now)) {
        return mealDateTime.difference(now);
      }
    }

    final nextBreakfast = mealTimes.first;
    final DateTime nextDayMeal = DateTime(
      now.year,
      now.month,
      now.day + 1,
      nextBreakfast.time.hour,
      nextBreakfast.time.minute,
    );

    return nextDayMeal.difference(now);
  }
}

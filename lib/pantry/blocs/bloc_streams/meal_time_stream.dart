import 'dart:async';

import 'package:my_learning/pantry/models/meal_time/meal_time_model.dart';

class MealTimeStream {
  final _controller = StreamController<MealTimeSetting>();
  Stream<MealTimeSetting> get updates => _controller.stream;

  void notify(MealTimeSetting mealTimeSetting) {
    _controller.add(mealTimeSetting);
  }

  void dispose() {
    _controller.close();
  }
}
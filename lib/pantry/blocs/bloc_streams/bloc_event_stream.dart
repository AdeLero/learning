import 'dart:async';

import 'package:my_learning/pantry/models/scheduled_meals/scheduled_meal_model.dart';
import 'package:my_learning/pantry/models/shopping_trips/shopping_frequency_model.dart';

class BlocEventStream {
  BlocEventStream._privateConstructor();

  static final BlocEventStream _instance =
      BlocEventStream._privateConstructor();

  factory BlocEventStream() => _instance;

  final StreamController<String> _blocStream =
      StreamController<String>.broadcast();
  final StreamController<List<ScheduledMeal>> _meals =
      StreamController<List<ScheduledMeal>>.broadcast();
final StreamController<ShoppingFrequency> _frequency =
StreamController<ShoppingFrequency>.broadcast();


  Stream<String> get blocStream => _blocStream.stream;
  Stream<List<ScheduledMeal>> get mealStream => _meals.stream;
  Stream<ShoppingFrequency> get frequencyStream => _frequency.stream;

  void add(String event) {
    _blocStream.add(event);
  }

  void send(List<ScheduledMeal> mealList) {
    _meals.add(mealList);
    print("sending $mealList");
  }

  void frequency(ShoppingFrequency frequency) {
    _frequency.add(frequency);
  }

  void dispose() {
    _blocStream.close();
  }
}

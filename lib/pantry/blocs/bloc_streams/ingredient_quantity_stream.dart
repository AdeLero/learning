import 'dart:async';
import 'package:my_learning/pantry/models/ingredient/ingredient_model.dart';

class IngredientQuantityStream {
  IngredientQuantityStream._privateConstructor();

  static final IngredientQuantityStream _instance =
      IngredientQuantityStream._privateConstructor();

  factory IngredientQuantityStream() => _instance;

  final _streamer = StreamController<Ingredient>.broadcast();
  Stream<Ingredient> get updates => _streamer.stream;

  void notify(Ingredient ingredient) {
    _streamer.add(ingredient);
  }

  void dispose() {
    _streamer.close();
  }
}

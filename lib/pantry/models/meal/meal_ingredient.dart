import 'package:json_annotation/json_annotation.dart';
import 'package:my_learning/pantry/models/ingredient/ingredient_model.dart';

part 'meal_ingredient.g.dart';

@JsonSerializable()
class MealIngredient {
  final Ingredient ingredient;
  final double quantity;

  MealIngredient({
    required this.ingredient,
    required this.quantity,
  });

  factory MealIngredient.fromJson (Map<String, dynamic> json) => _$MealIngredientFromJson(json);
  Map<String,dynamic> toJson() => _$MealIngredientToJson(this);
}

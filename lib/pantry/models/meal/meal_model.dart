import 'package:json_annotation/json_annotation.dart';
import 'package:my_learning/pantry/models/meal/meal_ingredient.dart';

part 'meal_model.g.dart';

@JsonSerializable()
class Meal {
  final String? id;
  final String name;
  final List<MealIngredient> mealIngredients;
  final String? image;
  final String? howToCook;
  final String? timeToCook;

  Meal({
    this.id,
    required this.name,
    required this.mealIngredients,
    this.image,
    this.howToCook,
    this.timeToCook,
  });

  Meal copyWith ({
    String? name,
    List<MealIngredient>? mealIngredients,
    String? image,
    String? howToCook,
    String? timeToCook,
}) {
    return Meal(
      name: name ?? this.name,
      mealIngredients: mealIngredients ?? this.mealIngredients,
      image: image ?? this.image,
      howToCook: howToCook ?? this.howToCook,
      timeToCook: timeToCook ?? this.timeToCook,
    );
  }

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
  Map<String, dynamic> toJson() => _$MealToJson(this);
}

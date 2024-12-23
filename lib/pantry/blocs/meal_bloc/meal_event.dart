part of 'meal_bloc.dart';

@immutable
sealed class MealEvent {}

class GetMealImage extends MealEvent {
  final String mealImagePath;
  final String name;

  GetMealImage({required this.mealImagePath, required this.name});
}

class AddMealIngredient extends MealEvent {
  final Ingredient ingredient;
  final double quantity;

  AddMealIngredient({required this.ingredient, required this.quantity});
}

class AddMeal extends MealEvent {
  final String name;
  final List<MealIngredient> mealIngredients;
  final String? image;
  final String? howToCook;
  final String? timeToCook;

  AddMeal({
    required this.name,
    required this.mealIngredients,
    this.image,
    this.howToCook,
    this.timeToCook,
  });
}

class IncrementIngredientQuantity extends MealEvent {
  final MealIngredient ingredient;

  IncrementIngredientQuantity({required this.ingredient});
}

class DecrementIngredientQuantity extends MealEvent {
  final MealIngredient ingredient;

  DecrementIngredientQuantity({required this.ingredient});
}

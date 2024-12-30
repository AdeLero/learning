part of 'meal_bloc.dart';

@immutable
sealed class MealEvent {}

class SetMealName extends MealEvent {
  final String name;

  SetMealName({required this.name});
}

class GetMealImage extends MealEvent {
  final String mealImagePath;


  GetMealImage({required this.mealImagePath});
}

class AddMealIngredient extends MealEvent {
  final Ingredient ingredient;
  final double quantity;

  AddMealIngredient({required this.ingredient, required this.quantity});
}

class DeleteMealIngredient extends MealEvent {
  final String name;

  DeleteMealIngredient({required this.name});
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

class EditMealEvent extends MealEvent {
  final String name;
  final List<MealIngredient> mealIngredients;
  final String? image;
  final String? howToCook;
  final String? timeToCook;

  EditMealEvent({
    required this.name,
    required this.mealIngredients,
    required this.image,
    required this.howToCook,
    required this.timeToCook,
  });
}

class DeleteMeal extends MealEvent {
  final String name;

  DeleteMeal({required this.name});
}

class GetMealIngredients extends MealEvent {
  final List<MealIngredient> mealIngredients;

  GetMealIngredients({required this.mealIngredients});
}

class IncrementIngredientQuantity extends MealEvent {
  final MealIngredient ingredient;

  IncrementIngredientQuantity({required this.ingredient});
}

class DecrementIngredientQuantity extends MealEvent {
  final MealIngredient ingredient;

  DecrementIngredientQuantity({required this.ingredient});
}

class NavigateMealBack extends MealEvent {}

class DeleteMealImage extends MealEvent {}

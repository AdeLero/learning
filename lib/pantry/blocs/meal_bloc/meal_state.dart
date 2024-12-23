part of 'meal_bloc.dart';

@immutable
sealed class MealState {}

final class MealInitial extends MealState {}

class ImageSelected extends MealState {
  final String imagePath;

  ImageSelected({required this.imagePath});
}

class MealTemplate extends MealState {
  final String name;
  final List<MealIngredient> mealIngredients;
  final String? image;
  final String? howToCook;
  final String? timeToCook;

  MealTemplate({
    required this.name,
    required this.mealIngredients,
    this.image,
    this.howToCook,
    this.timeToCook,
  });
}

class MealsLoaded extends MealState {
  final List<Meal> meals ;

  MealsLoaded({required this.meals});
}

class MealAddingError extends MealState {
  final String message;

  MealAddingError({required this.message});
}


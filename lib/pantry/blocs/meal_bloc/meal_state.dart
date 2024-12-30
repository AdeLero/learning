part of 'meal_bloc.dart';

@immutable
sealed class MealState {}

final class MealInitial extends MealState {}

class ImageSelected extends MealState {
  final String imagePath;

  ImageSelected({required this.imagePath});
}

class MealTemplate extends MealState {
  final String? name;
  final List<MealIngredient>? mealIngredients;
  final String? image;
  final String? howToCook;
  final String? timeToCook;

  MealTemplate({
    this.name,
    this.mealIngredients,
    this.image,
    this.howToCook,
    this.timeToCook,
  });

  MealTemplate copyWith({
    String? name,
    List<MealIngredient>? mealIngredients,
    String? image,
    String? howToCook,
    String? timeToCook,
}) {
    return MealTemplate(
      name: name ?? this.name,
      mealIngredients: mealIngredients ?? this.mealIngredients,
      image: image ?? this.image,
      timeToCook: timeToCook ?? this.timeToCook,
      howToCook: howToCook ?? this.howToCook,
    );
  }
}

class MealsLoaded extends MealState {
  final List<Meal> meals ;

  MealsLoaded({required this.meals});
}

class MealAddingError extends MealState {
  final String message;

  MealAddingError({required this.message});
}


import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_learning/pantry/models/ingredient/ingredient_model.dart';
import 'package:my_learning/pantry/models/meal/meal_ingredient.dart';
import 'package:my_learning/pantry/models/meal/meal_model.dart';

part 'meal_event.dart';
part 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  MealBloc() : super(MealInitial()) {
    on<GetMealImage>(getMealImage);
    on<AddMealIngredient>(addMealIngredient);
    on<AddMeal>(addMeal);
    on<IncrementIngredientQuantity>(incrementIngredientQuantity);
    on<DecrementIngredientQuantity>(decrementIngredientQuantity);
  }
  List<Meal> meals = [];
  List<MealIngredient> draftMealIngredients = [];
  String? draftImagePath;
  String? mealName;

  void getMealImage(GetMealImage event, Emitter<MealState> emit) {
    draftImagePath = event.mealImagePath;
    mealName = event.name;
    print("meal Ingredient: ${draftMealIngredients}");
    emit(
      MealTemplate(
        name: mealName!,
        mealIngredients: draftMealIngredients,
        image: draftImagePath,
      ),
    );
  }

  void addMealIngredient(AddMealIngredient event, Emitter<MealState> emit) {
    draftMealIngredients.add(
        MealIngredient(ingredient: event.ingredient, quantity: event.quantity));
    print("meal Ingredient: ${draftMealIngredients.first.ingredient.name}");
    emit(MealTemplate(
      name: mealName!,
      mealIngredients: draftMealIngredients,
      image: draftImagePath,
    ));
  }

  void addMeal(AddMeal event, Emitter<MealState> emit) {
    print("state: $state");
    meals.add(Meal(
      name: event.name,
      image: event.image,
      mealIngredients: event.mealIngredients,
      howToCook: event.howToCook,
      timeToCook: event.timeToCook,
    ));
    emit(MealsLoaded(meals: meals));
    print("Meal list updated");

  }

  void incrementIngredientQuantity(
      IncrementIngredientQuantity event, Emitter<MealState> emit) {
    if (state is MealTemplate) {
      final currentState = state as MealTemplate;
      final mealIngredients = currentState.mealIngredients.map((ingredient) {
        if (ingredient == event.ingredient) {
          return ingredient.copyWith(quantity: ingredient.quantity + 1);
        }
        return ingredient;
      }).toList();

      emit(
        MealTemplate(
          name: currentState.name,
          image: currentState.image,
          mealIngredients: mealIngredients,
        ),
      );
    }
  }

  void decrementIngredientQuantity(
      DecrementIngredientQuantity event, Emitter<MealState> emit) {
    if (state is MealTemplate) {
      final currentState = state as MealTemplate;
      final mealIngredients = currentState.mealIngredients.map((ingredient) {
        if (ingredient == event.ingredient) {
          return ingredient.copyWith(quantity: ingredient.quantity - 1);
        }
        return ingredient;
      }).toList();

      emit(
        MealTemplate(
          name: currentState.name,
          image: currentState.image,
          mealIngredients: mealIngredients,
        ),
      );
    }
  }
}

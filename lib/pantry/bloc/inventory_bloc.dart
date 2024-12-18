import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_learning/pantry/models/ingredient/ingredient_model.dart';
import 'package:my_learning/pantry/models/meal/meal_ingredient.dart';
import 'package:my_learning/pantry/models/meal/meal_model.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc() : super(InventoryInitial()) {
    on<AddIngredientToInventory>(addIngredientToInventory);
    on<AddMealIngredientToList>(addMealIngredientToList);
    on<AddMealToInventory>(addMealToInventory);
  }

  List<Ingredient> inventory = [];
  List<MealIngredient> mealIngredients = [];
  List<Meal> meals = [];

  void addIngredientToInventory(
      AddIngredientToInventory event, Emitter<InventoryState> emit) {
    inventory.add(Ingredient(
      name: event.name,
      quantity: event.quantity,
      unitOfMeasurement: event.unitOfMeasurement,
      criticalQty: event.criticalQty,
    ));
    emit(InventoryLoaded(inventory: inventory));
  }

  void addMealIngredientToList(
      AddMealIngredientToList event, Emitter<InventoryState> emit) {
    mealIngredients.add(MealIngredient(
      ingredient: event.ingredient,
      quantity: event.quantity,
    ));
  }

  void addMealToInventory(
      AddMealToInventory event, Emitter<InventoryState> emit) {
    meals.add(Meal(
      name: event.mealName,
      mealIngredients: event.mealIngredients,
      image: event.image,
      timeToCook: event.timeToCook,
      howToCook: event.howToCook,
    ));
  }
}

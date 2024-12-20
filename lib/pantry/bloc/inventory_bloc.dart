import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_learning/pantry/models/ingredient/ingredient_model.dart';
import 'package:my_learning/pantry/models/meal/meal_ingredient.dart';
import 'package:my_learning/pantry/models/meal/meal_model.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends HydratedBloc<InventoryEvent, InventoryState> {
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
    print("state before: $state");
    if (event.name.isNotEmpty &&
        event.quantity.isNotEmpty &&
        event.unitOfMeasurement.isNotEmpty &&
        event.criticalQty.isNotEmpty) {
      double ingredientQty = double.parse(event.quantity);
      double ingredientCriticalQty = double.parse(event.criticalQty);
      inventory.add(Ingredient(
        name: event.name,
        quantity: ingredientQty,
        unitOfMeasurement: event.unitOfMeasurement,
        criticalQty: ingredientCriticalQty,
      ));
      emit(InventoryLoaded(inventory: inventory));
      print("state after: $state");
    } else {
      emit(InventoryError(message: "Please Fill All Fields"));
    }
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

  @override
  InventoryState? fromJson(Map<String, dynamic> json) {
    if (json["inventory"] != null) {
      final inventory = (json["inventory"] as List)
          .map((item) => Ingredient.fromJson(item as Map<String, dynamic>))
          .toList();
      return InventoryLoaded(inventory: inventory);
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Map<String, dynamic>? toJson(InventoryState state) {
    if (state is InventoryLoaded) {
      final inventoryJson =
          state.inventory.map((ingredient) => ingredient.toJson()).toList();
      return {"inventory": inventoryJson};
    } else {
      throw UnimplementedError();
    }
  }
}

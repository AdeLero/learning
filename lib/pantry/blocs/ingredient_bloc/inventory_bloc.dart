import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_learning/pantry/blocs/bloc_streams/ingredient_quantity_stream.dart';
import 'package:my_learning/pantry/models/ingredient/ingredient_model.dart';
import 'package:my_learning/pantry/models/meal/meal_ingredient.dart';
import 'package:my_learning/pantry/models/meal/meal_model.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends HydratedBloc<InventoryEvent, InventoryState> {
  final IngredientQuantityStream ingredientQuantityStream =
      IngredientQuantityStream();

  InventoryBloc() : super(InventoryInitial()) {
    on<AddIngredientToInventory>(addIngredientToInventory);
    on<EditIngredientEvent>(editIngredient);
    on<NavigateBack>(navigateBack);
    on<DeleteIngredient>(deleteIngredient);
    updateInventory();
  }

  List<Ingredient> inventory = [];
  List<MealIngredient> mealIngredients = [];
  List<Meal> meals = [];

  void addIngredientToInventory(
      AddIngredientToInventory event, Emitter<InventoryState> emit) {
    if ([event.name, event.quantity, event.unitOfMeasurement, event.criticalQty]
        .any((field) => field.isEmpty)) {
      emit(InventoryError(message: "Please Fill all Fields"));
      return;
    }

    try {
      double ingredientQty = double.parse(event.quantity);
      double ingredientCriticalQty = double.parse(event.criticalQty);

      inventory.add(Ingredient(
        name: event.name,
        quantity: ingredientQty,
        unitOfMeasurement: event.unitOfMeasurement,
        criticalQty: ingredientCriticalQty,
      ));

      emit(InventoryLoaded(inventory: inventory));
    } catch (e) {
      emit(InventoryError(message: "Invalid number format for quantity"));
    }
  }

  void navigateBack(NavigateBack event, Emitter<InventoryState> emit) {
    if (state is! InventoryLoaded) {
      emit(InventoryLoaded(inventory: inventory));
    }
  }

  void editIngredient(EditIngredientEvent event, Emitter<InventoryState> emit) {
    try {
      final ingredient = inventory.indexWhere((ing) => ing.name == event.name);
      if (ingredient == -1) {
        emit(InventoryError(message: "Ingredient not found"));
        return;
      }

      inventory[ingredient] = inventory[ingredient].copyWith(
        quantity: double.parse(event.quantity),
        unitOfMeasurement: event.unitOfMeasurement,
        criticalQty: double.parse(event.criticalQty),
      );
      emit(InventoryLoaded(inventory: inventory));
    } catch (e) {
      emit(InventoryError(message: "Invalid data"));
    }
  }

  void deleteIngredient(DeleteIngredient event, Emitter<InventoryState> emit) {
    try {
      final index = inventory.indexWhere(
        (ingredient) => ingredient.name == event.name,
      );

      if (index == -1) {
        emit(InventoryError(message: "Ingredient not found"));
        return;
      }

      inventory.removeAt(index);

      if (inventory.isEmpty) {
        emit(InventoryInitial());
      } else {
        emit(InventoryLoaded(inventory: inventory));
      }
    } catch (e) {
      emit(InventoryError(message: "Failed to delete Ingredient"));
    }
  }

  void updateInventory() {
    print("Setting up listener for updates...");
    ingredientQuantityStream.updates.listen((p) {
      print("Listener triggered for: ${p.name}");
      final ingredient = inventory.firstWhere((ing) => ing.name == p.name);
      final newQty = ingredient.quantity - p.quantity;
      add(EditIngredientEvent(
        name: ingredient.name,
        unitOfMeasurement: ingredient.unitOfMeasurement,
        quantity: newQty.toString(),
        criticalQty: ingredient.criticalQty.toString(),
      ));
      print("${p.name} as in");
    });
  }

  @override
  InventoryState? fromJson(Map<String, dynamic> json) {
    try {
      if (json["inventory"] != null) {
        final inventory = (json["inventory"] as List)
            .map((item) => Ingredient.fromJson(item as Map<String, dynamic>))
            .toList();

        return InventoryLoaded(inventory: inventory);
      } else if (json["error"] != null) {
        return InventoryError(message: json["error"]);
      } else if (json["initial"] != null) {
        return InventoryInitial();
      }
    } catch (e) {
      print("Error parsing state from JSON: $e");
    }

    return InventoryInitial();
  }

  @override
  Map<String, dynamic>? toJson(InventoryState state) {
    if (state is InventoryLoaded) {
      final inventoryJson =
          state.inventory.map((ingredient) => ingredient.toJson()).toList();
      return {"inventory": inventoryJson};
    } else if (state is InventoryError) {
      return {"error": state.message};
    } else if (state is InventoryInitial) {
      return {"initial": true};
    } else {
      throw UnimplementedError();
    }
  }
}

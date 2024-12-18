part of 'inventory_bloc.dart';

@immutable
sealed class InventoryEvent {}

class AddIngredientToInventory extends InventoryEvent {
  final String name;
  final String unitOfMeasurement;
  final double quantity;
  final double? criticalQty;

  AddIngredientToInventory(
      {required this.name,
      required this.unitOfMeasurement,
      required this.quantity,
      required this.criticalQty});
}

class AddMealIngredientToList extends InventoryEvent {
  final Ingredient ingredient;
  final double quantity;

  AddMealIngredientToList({
    required this.ingredient,
    required this.quantity,
  });
}

class AddMealToInventory extends InventoryEvent {
  final String mealName;
  final String? image;
  final List<MealIngredient> mealIngredients;
  final String? howToCook;
  final String? timeToCook;

  AddMealToInventory({
    required this.mealName,
    required this.mealIngredients,
    this.image,
    this.howToCook,
    this.timeToCook,
  });
}

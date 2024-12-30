part of 'inventory_bloc.dart';

@immutable
sealed class InventoryEvent {}

class AddIngredientToInventory extends InventoryEvent {
  final String name;
  final String unitOfMeasurement;
  final String quantity;
  final String criticalQty;

  AddIngredientToInventory({
    required this.name,
    required this.unitOfMeasurement,
    required this.quantity,
    required this.criticalQty,
  });
}

class NavigateBack extends InventoryEvent {}

class EditIngredientEvent extends InventoryEvent {
  final String name;
  final String unitOfMeasurement;
  final String quantity;
  final String criticalQty;

  EditIngredientEvent({
    required this.name,
    required this.unitOfMeasurement,
    required this.quantity,
    required this.criticalQty,
  });
}

class DeleteIngredient extends InventoryEvent {
  final String name;

  DeleteIngredient({required this.name});
}

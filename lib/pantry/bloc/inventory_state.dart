part of 'inventory_bloc.dart';

@immutable
sealed class InventoryState {}

final class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryLoaded extends InventoryState {
  final List<Ingredient> inventory;

  InventoryLoaded({required this.inventory});
}
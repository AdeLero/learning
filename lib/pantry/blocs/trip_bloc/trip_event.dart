part of 'trip_bloc.dart';

@immutable
sealed class TripEvent {}

class TempFrequencySelected extends TripEvent {
  final ShoppingFrequency frequency;

  TempFrequencySelected({required this.frequency});
}

class ChangeTripFrequency extends TripEvent {
  final ShoppingFrequency frequency;

  ChangeTripFrequency({required this.frequency});
}

class GenerateShoppingList extends TripEvent {}

class SaveShoppingList extends TripEvent {}



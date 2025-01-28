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

class GenerateShoppingList extends TripEvent {
  final DateTime date;

  GenerateShoppingList({required this.date});
}

class GetTripDate extends TripEvent {
  final DateTime tripDate;

  GetTripDate({required this.tripDate});
}

class SaveShoppingList extends TripEvent {
  final ShoppingTrip shoppingTrip;

  SaveShoppingList({required this.shoppingTrip});
}



part of 'trip_bloc.dart';

@immutable
sealed class TripState {}

final class TripInitial extends TripState {}

class TempIntervalSelected extends TripState {
  final ShoppingFrequency frequency;

  TempIntervalSelected({required this.frequency});
}

class TripIntervalUpdated extends TripState {
  final ShoppingFrequency frequency;

  TripIntervalUpdated({required this.frequency});
}

class TripListGenerated extends TripState {
  final ShoppingTrip shoppingList;

  TripListGenerated({required this.shoppingList});
}

class TripListSaved extends TripState {
  final List<ShoppingTrip> savedLists;

  TripListSaved({required this.savedLists});
}

part of 'trip_bloc.dart';

@immutable
sealed class TripState {}

final class TripInitial extends TripState {}

final class TripLoading extends TripState {}

class TempIntervalSelected extends TripState {
  final ShoppingFrequency frequency;

  TempIntervalSelected({required this.frequency});
}

class TripIntervalUpdated extends TripState {
  final ShoppingFrequency frequency;

  TripIntervalUpdated({required this.frequency});
}

class TripListDetailing extends TripState {
  final DateTime tripDate;

  TripListDetailing({required this.tripDate});
}

class TripListGenerated extends TripState {
  final ShoppingTrip shoppingList;

  TripListGenerated({required this.shoppingList});
}

class TripListSaved extends TripState {
  final List<ShoppingTrip> savedLists;

  TripListSaved({required this.savedLists});
}

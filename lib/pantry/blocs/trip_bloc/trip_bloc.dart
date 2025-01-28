import 'dart:async';
import 'dart:isolate';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_learning/pantry/blocs/bloc_streams/bloc_event_stream.dart';
import 'package:my_learning/pantry/blocs/ingredient_bloc/inventory_bloc.dart';
import 'package:my_learning/pantry/models/shopping_trips/shopping_frequency_model.dart';
import 'package:my_learning/pantry/models/shopping_trips/shopping_trip_model.dart';
import 'package:my_learning/pantry/models/shopping_trips/trip_ingredient_model.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final BlocEventStream blocEventStream = BlocEventStream();

  TripBloc() : super(TripInitial()) {
    on<TempFrequencySelected>(tempFrequencySelected);
    on<ChangeTripFrequency>(changeTripFrequency);
    on<GetTripDate>(getTripDate);
    on<SaveShoppingList>(saveShoppingList);
    on<GenerateShoppingList>((event, emit) async {
      await for (final state in generateShoppingList(event)) {
        emit(state);
      }
    });
  }

  ShoppingFrequency? frequency;

  void tempFrequencySelected(
      TempFrequencySelected event, Emitter<TripState> emit) {
    frequency = event.frequency;
    emit(TempIntervalSelected(frequency: frequency!));
  }

  void changeTripFrequency(ChangeTripFrequency event, Emitter<TripState> emit) async{

    frequency = event.frequency;
    emit(TripIntervalUpdated(frequency: frequency!));
  }


  Stream<TripState> generateShoppingList(GenerateShoppingList event) async* {
    yield TripLoading();


    try {
      blocEventStream.add("GenerateShoppingList");
      blocEventStream.add("GetInventory");

      ShoppingFrequency freq = (state is TripIntervalUpdated)
          ? (state as TripIntervalUpdated).frequency
          : ShoppingFrequency.weekly;
      blocEventStream.frequency(freq);

      await for (final list in blocEventStream.mealStream) {
        Map<String, double> ingredientTotals = {};

        for (var meal in list) {
          for (var ingredient in meal.meal.mealIngredients) {
            final ingredientName = ingredient.ingredient.name;
            final ingredientQuantity = ingredient.quantity * meal.servings;

            if (ingredientTotals.containsKey(ingredientName)) {
              ingredientTotals[ingredientName] =
                  ingredientTotals[ingredientName]! + ingredientQuantity;
            } else {
              ingredientTotals[ingredientName] = ingredientQuantity;
            }
          }
        }

        await for (final inventory in blocEventStream.inventoryStream) {
          for (var inventoryItem in inventory) {
            final inventoryName = inventoryItem.name;
            final inventoryQuantity = inventoryItem.quantity;

            if (ingredientTotals.containsKey(inventoryName)) {
              final adjustedQuantity =
                  ingredientTotals[inventoryName]! - inventoryQuantity;

              if (adjustedQuantity <= 0) {
                ingredientTotals.remove(inventoryName);
              } else {
                ingredientTotals[inventoryName] = adjustedQuantity;
              }
            }
          }
        }

        final adjustedTripList = ingredientTotals.entries.map((entry) {
          final ing = entry.key;
          final total = entry.value;
          return TripIngredient(name: ing, quantity: total);
        }).toList();

        ShoppingTrip? trip = ShoppingTrip(shoppingList: adjustedTripList, date: event.date);

        yield TripListGenerated(
          shoppingList: trip,
        );

        trip = null;
      }
    } catch (e) {
      print("Error during shopping list generation: $e");
    }
  }

  void getTripDate(GetTripDate event, Emitter<TripState> emit) {
    DateTime date = DateTime.now();

    date = event.tripDate;

    emit(TripListDetailing(tripDate: date));
  }

  List<ShoppingTrip> trips = [];

  void saveShoppingList(SaveShoppingList event, Emitter<TripState> emit) {
    trips.add(event.shoppingTrip);

    emit(TripListSaved(savedLists: trips));
  }
}

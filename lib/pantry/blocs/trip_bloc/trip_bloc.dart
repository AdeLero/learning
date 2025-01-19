import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_learning/pantry/blocs/bloc_streams/bloc_event_stream.dart';
import 'package:my_learning/pantry/models/ingredient/ingredient_model.dart';
import 'package:my_learning/pantry/models/shopping_trips/shopping_frequency_model.dart';
import 'package:my_learning/pantry/models/shopping_trips/shopping_trip_model.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final BlocEventStream blocEventStream = BlocEventStream();

  TripBloc() : super(TripInitial()) {
    on<TempFrequencySelected>(tempFrequencySelected);
    on<ChangeTripFrequency>(changeTripFrequency);
    on<GenerateShoppingList>(generateShoppingList);
  }

  ShoppingFrequency? frequency;

  void tempFrequencySelected(
      TempFrequencySelected event, Emitter<TripState> emit) {
    frequency = event.frequency;
    emit(TempIntervalSelected(frequency: frequency!));
  }

  void changeTripFrequency(ChangeTripFrequency event, Emitter<TripState> emit) {
    frequency = event.frequency;
    emit(TripIntervalUpdated(frequency: frequency!));
  }

  void generateShoppingList(
      GenerateShoppingList event, Emitter<TripState> emit) {


    blocEventStream.add("GenerateShoppingList");

    final currentState = state;
    if (currentState is TripIntervalUpdated) {
      final freq = currentState.frequency;
      blocEventStream.frequency(freq);
    } else {
      blocEventStream.add("SetFrequency");
    }

    blocEventStream.mealStream.listen((list) {
      Map<String, double> ingredientTotals = {};
      for (var meal in list) {
        print("list: $list");
        for (var ingredient in meal.meal.mealIngredients) {
          final ingredientName = ingredient.ingredient.name;
          final ingredientQuantity = ingredient.quantity * meal.servings;

          if (ingredientTotals.containsKey(ingredientName)) {
            ingredientTotals[ingredientName] = ingredientTotals[ingredientName]! + ingredientQuantity;
          } else {
            ingredientTotals[ingredientName] = ingredientQuantity;
          }
        }
      }
      ingredientTotals.forEach((name, total) {
        print('Ingredient: $name, Total Quantity: $total');
      });
    });

  }
}

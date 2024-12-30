import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_learning/pantry/models/ingredient/ingredient_model.dart';
import 'package:my_learning/pantry/models/meal/meal_ingredient.dart';
import 'package:my_learning/pantry/models/meal/meal_model.dart';

part 'meal_event.dart';
part 'meal_state.dart';

class MealBloc extends HydratedBloc<MealEvent, MealState> {
  MealBloc() : super(MealInitial()) {
    on<SetMealName>(setMealName);
    on<GetMealImage>(getMealImage);
    on<GetMealIngredients>(getMealIngredients);
    on<AddMealIngredient>(addMealIngredient);
    on<DeleteMealIngredient>(deleteMealIngredient);
    on<AddMeal>(addMeal);
    on<IncrementIngredientQuantity>(incrementIngredientQuantity);
    on<DecrementIngredientQuantity>(decrementIngredientQuantity);
    on<NavigateMealBack>(navigateBack);
    on<DeleteMealImage>(deleteMealImage);
    on<DeleteMeal>(deleteMeal);
    on<EditMealEvent>(editMeal);
  }
  List<Meal> meals = [];
  List<MealIngredient> draftMealIngredients = [];
  String? draftImagePath;
  String? mealName;

  void setMealName(SetMealName event, Emitter<MealState> emit) {
    mealName = event.name;

    final currentState = state;
    if (currentState is MealTemplate) {
      emit(currentState.copyWith(
        name: mealName,
      ));
    } else {
      emit(MealTemplate(
        name: mealName,
      ));
    }
    print("Meal Name: $mealName");
  }

  void getMealImage(GetMealImage event, Emitter<MealState> emit) {
    draftImagePath ??= event.mealImagePath;

    final currentState = state;
    if (currentState is MealTemplate) {
      emit(currentState.copyWith(
        image: event.mealImagePath,
      ));
    } else {
      emit(
        MealTemplate(
          image: draftImagePath,
        ),
      );
    }
  }

  void getMealIngredients(GetMealIngredients event, Emitter<MealState> emit) {
    draftMealIngredients = event.mealIngredients;

    final currentState = state;
    if (currentState is MealTemplate) {
      emit(currentState.copyWith(mealIngredients: draftMealIngredients));
    } else {
      emit(MealTemplate(
        mealIngredients: draftMealIngredients,
      ));
    }
  }

  void addMealIngredient(AddMealIngredient event, Emitter<MealState> emit) {
    try {
      final isDuplicate = draftMealIngredients.any(
        (mig) => mig.ingredient.name == event.ingredient.name,
      );

      if (isDuplicate) {
        emit(MealAddingError(
          message: "${event.ingredient.name} is already on the List",
        ));
        return;
      }

      draftMealIngredients.add(MealIngredient(
          ingredient: event.ingredient, quantity: event.quantity));

      final currentState = state;
      if (currentState is MealTemplate) {
        emit(currentState.copyWith(
          mealIngredients: draftMealIngredients,
        ));
      } else {
        emit(MealTemplate(
          mealIngredients: draftMealIngredients,
        ));
      }
    } catch (e) {
      emit(MealAddingError(message: e.toString()));
    }
  }

  void deleteMealIngredient(
      DeleteMealIngredient event, Emitter<MealState> emit) {
    try {
      final index = draftMealIngredients.indexWhere(
        (mig) => mig.ingredient.name == event.name,
      );

      if (index == -1) {
        emit(MealAddingError(message: "Error deleting Ingredient"));
      }

      draftMealIngredients.removeAt(index);

      emit(MealTemplate(
        name: mealName!,
        mealIngredients: draftMealIngredients,
        image: draftImagePath,
      ));
    } catch (e) {
      emit(MealAddingError(message: e.toString()));
    }
  }

  void addMeal(AddMeal event, Emitter<MealState> emit) {
    try {

      if ([event.name, event.mealIngredients].any((field) => field == null)) {
        emit(MealAddingError(message: "Please Fill name and Ingredients"));
        return;
      }
      meals.add(Meal(
        name: event.name,
        image: event.image,
        mealIngredients: event.mealIngredients,
        howToCook: event.howToCook,
        timeToCook: event.timeToCook,
      ));

      mealName = null;
      draftImagePath = null;
      draftMealIngredients.clear();

      emit(MealsLoaded(meals: meals));
    } catch (e) {
      emit(MealAddingError(message: e.toString()));
    }
  }

  void editMeal(EditMealEvent event, Emitter<MealState> emit) {
    try {
      final index = meals.indexWhere((meal) => meal.name == event.name);

      if (index == -1) {
        emit(MealAddingError(message: "Meal not found"));
      }

      meals[index] = meals[index].copyWith(
        mealIngredients: event.mealIngredients,
        image: event.image,
        howToCook: event.howToCook,
        timeToCook: event.timeToCook,
      );
      emit(MealsLoaded(meals: meals));
    } catch (e) {
      emit(MealAddingError(message: e.toString()));
    }
  }

  void deleteMeal(DeleteMeal event, Emitter<MealState> emit) {
    try {
      final index = meals.indexWhere(
        (meal) => meal.name == event.name,
      );

      if (index == -1) {
        emit(MealAddingError(message: "Error deleting Meal"));
      }

      meals.removeAt(index);

      if (meals.isEmpty) {
        emit(MealInitial());
      } else {
        emit(MealsLoaded(meals: meals));
      }
    } catch (e) {
      emit(MealAddingError(message: e.toString()));
    }
  }

  void incrementIngredientQuantity(
      IncrementIngredientQuantity event, Emitter<MealState> emit) {
    if (state is MealTemplate) {
      final currentState = state as MealTemplate;
      final mealIngredients = currentState.mealIngredients?.map((ingredient) {
        if (ingredient == event.ingredient) {
          return ingredient.copyWith(quantity: ingredient.quantity + 1);
        }
        return ingredient;
      }).toList();

      emit(
        MealTemplate(
          name: currentState.name,
          image: currentState.image,
          mealIngredients: mealIngredients,
        ),
      );
    }
  }

  void decrementIngredientQuantity(
      DecrementIngredientQuantity event, Emitter<MealState> emit) {
    if (state is MealTemplate) {
      final currentState = state as MealTemplate;
      final mealIngredients = currentState.mealIngredients?.map((ingredient) {
        if (ingredient == event.ingredient) {
          return ingredient.copyWith(quantity: ingredient.quantity - 1);
        }
        return ingredient;
      }).toList();

      emit(
        MealTemplate(
          name: currentState.name,
          image: currentState.image,
          mealIngredients: mealIngredients,
        ),
      );
    }
  }

  void navigateBack(NavigateMealBack event, Emitter<MealState> emit) {
    if (state is! MealsLoaded){
      mealName = null;
      draftImagePath = null;
      draftMealIngredients.clear();


      if (meals.isEmpty) {
        emit(MealInitial());
      } else {
        emit(MealsLoaded(meals: meals));
      }
    } else {
      emit(MealsLoaded(meals: meals));
    }
  }

  void deleteMealImage(DeleteMealImage event, Emitter<MealState> emit) async {
    if (draftImagePath != null) {
      try {
        final file = File(draftImagePath!);
        if (await file.exists()) {
          await file.delete();
        }
        draftImagePath = null;
      } catch (e) {
        emit(MealAddingError(message: e.toString()));
      }

      emit(MealTemplate(
        name: mealName!,
        mealIngredients: draftMealIngredients,
      ));
    }
  }

  @override
  MealState? fromJson(Map<String, dynamic> json) {
    try {
      if (json["meals"] != null) {
        final meals = (json["meals"] as List)
            .map((meal) => Meal.fromJson(meal as Map<String, dynamic>))
            .toList();

        return MealsLoaded(meals: meals);
      } else if (json["error"] != null) {
        return MealAddingError(message: json["error"]);
      } else if (json["initial"] != null) {
        return MealInitial();
      }
    } catch (e) {
      print("Error parsing state from JSon: $e");
    }

    return MealInitial();
  }

  @override
  Map<String, dynamic> toJson(MealState state) {
    if (state is MealsLoaded) {
      final mealsJson = state.meals.map((meal) => meal.toJson()).toList();
      return {"meals": mealsJson};
    } else if (state is MealAddingError) {
      return {"error": state.message};
    } else if (state is MealTemplate) {
      return {
        "name": state.name,
        "mealIngredients": state.mealIngredients
            ?.map((ingredient) => ingredient.toJson())
            .toList(),
        "image": state.image,
        "howToCook": state.howToCook,
        "timeToCook": state.timeToCook,
      };
    } else if (state is MealInitial) {
      return {"initial": true};
    } else {
      throw UnimplementedError();
    }
  }
}

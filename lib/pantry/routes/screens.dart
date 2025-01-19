import 'package:flutter/material.dart';
import 'package:my_learning/customizations/appRoutes/app_routes.dart';
import 'package:my_learning/pantry/models/ingredient/ingredient_model.dart';
import 'package:my_learning/pantry/models/meal/meal_model.dart';
import 'package:my_learning/pantry/routes/routes.dart';
import 'package:my_learning/pantry/screens/account/meal_time_settings_screen.dart';
import 'package:my_learning/pantry/screens/account/shopping_trip_settings.dart';
import 'package:my_learning/pantry/screens/ingredient/edit_ingredient.dart';
import 'package:my_learning/pantry/screens/meal/edit_meal.dart';
import 'package:my_learning/pantry/screens/auth/pantry_splash_screen.dart';
import 'package:my_learning/pantry/screens/meal/meal_inventory_screen.dart';
import 'package:my_learning/pantry/screens/scheduled_meals/edit_scheduled_meal.dart';
import 'package:my_learning/pantry/screens/scheduled_meals/schedule_meal.dart';

final screens = [
  AppRoutes(
    name: Routes.splash,
    page: (_) => const PantrySplashScreen(),
  ),
  AppRoutes(
    name: Routes.editIngredient,
    page: (arguments) => EditIngredient(ingredient: arguments as Ingredient),
  ),
  AppRoutes(
    name: Routes.editMeal,
    page: (arguments) => EditMeal(meal: arguments as Meal),
  ),
  AppRoutes(
    name: Routes.scheduleMeal,
    page: (_) => const ScheduleMeal(),
  ),
  AppRoutes(
    name: Routes.editScheduledMeal,
    page: (arguments) =>
        EditScheduledMeal(scheduledMealId: arguments as String),
  ),
  AppRoutes(
    name: Routes.mealInventory,
    page: (_) => const MealInventoryScreen(),
  ),

  AppRoutes(
    name: Routes.mealTimeSettings,
    page: (_) => const MealTimeSettingsScreen(),
  ),

  AppRoutes(
    name: Routes.shoppingTripSettings,
    page: (_) => const ShoppingTripSettings(),
  ),
];

Map<String, Widget Function(BuildContext)> appRoutes = {
  for (var route in screens)
    route.name: (context) {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      return route.page!(arguments);
    },
};

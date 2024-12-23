import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning/customizations/custom_widgets/pantry_button.dart';
import 'package:my_learning/pantry/blocs/meal_bloc/meal_bloc.dart';
import 'package:my_learning/pantry/custom_widgets/empty_display.dart';
import 'package:my_learning/pantry/custom_widgets/inventory_display_widget.dart';
import 'package:my_learning/pantry/screens/meal/create_meal.dart';
import 'package:my_learning/pantry/screens/meal/meal_detail.dart';

class MealInventoryScreen extends StatelessWidget {
  const MealInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<MealBloc, MealState>(builder: (context, state) {
            if (state is MealsLoaded) {
              final inventory = state.meals;
              return InventoryDisplayWidget(
                inventory: inventory,
                onTap: (index) {
                  final meal = inventory[index];
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => MealDetail(meal: meal),
                    )
                  );
                },
              );
            } else if (state is MealInitial || state is MealAddingError ||
                (state as MealsLoaded).meals.isEmpty) {
              return const EmptyDisplay(
                imagePath: "lib/assets/images/no_meals_planned.png",
                text: "You do not have any Meals",
              );
            }
            return PantryButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateMeal(),
                  ),
                );
              },
              label: "Create Meal",
            );
          }),
        ),
      ),
    );
  }
}

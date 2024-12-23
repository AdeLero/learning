import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning/customizations/custom_widgets/pantry_button.dart';
import 'package:my_learning/pantry/blocs/bloc/inventory_bloc.dart';
import 'package:my_learning/pantry/custom_widgets/empty_display.dart';
import 'package:my_learning/pantry/custom_widgets/inventory_display_widget.dart';
import 'package:my_learning/pantry/screens/ingredient/add_ingredient.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<InventoryBloc, InventoryState>(
              builder: (context, state) {
                if (state is InventoryLoaded) {
                  final inventory = state.inventory;
                  return InventoryDisplayWidget(inventory: inventory);
                } else if (state is InventoryInitial) {
                  return EmptyDisplay(
                    imagePath: "lib/assets/images/no_ingredients.png",
                    text: "You do not have any Ingredients",
                  );
                }
            return PantryButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddIngredient(),
                ),
              );
            }, label: "Create Ingredient");
          }),
        ),
      ),
    );
  }
}

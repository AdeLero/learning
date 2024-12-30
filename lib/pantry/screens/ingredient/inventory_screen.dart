import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning/customizations/custom_widgets/pantry_button.dart';
import 'package:my_learning/pantry/blocs/ingredient_bloc/inventory_bloc.dart';
import 'package:my_learning/pantry/custom_widgets/alert_dialog.dart';
import 'package:my_learning/pantry/custom_widgets/empty_display.dart';
import 'package:my_learning/pantry/custom_widgets/inventory_display_widget.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/routes/routes.dart';
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
                if (state is InventoryLoaded || state is InventoryError) {
                  final inventory = (state as InventoryLoaded).inventory;

                  return InventoryDisplayWidget(
                      inventory: inventory,
                    onTap: (index) {
                      final ingredient = inventory[index];
                      Navigator.pushNamed(context, Routes.editIngredient, arguments: ingredient);
                    },
                    rightOnPressed: (index) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            final ingredient = inventory[index];
                            return MyAlertDialog(
                                title: "Delete ${ingredient.name}?",
                                buttonText: "Delete",
                                content: Text("Are you sure you want to delete ${ingredient.name}?"),
                                onSubmit: () {
                                  context.read<InventoryBloc>().add(DeleteIngredient(name: ingredient.name));
                                }
                            );
                          }
                        );
                    },
                  );
                } else if (state is InventoryInitial) {
                  return const EmptyDisplay(
                    imagePath: "lib/assets/images/no_ingredients.png",
                    text: "You do not have any Ingredients",
                  );
                }
            return PantryButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddIngredient(),
                ),
              );
            }, label: "Create Ingredient", buttonColor: pantryTheme.primaryColor,
            );
          }),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/pantry_button.dart';
import 'package:my_learning/pantry/bloc/inventory_bloc.dart';
import 'package:my_learning/pantry/models/ingredient/ingredient_model.dart';
import 'package:my_learning/pantry/screens/add_ingredient.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InventoryBloc(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                PantryButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddIngredient(),
                        ),
                      );
                    },
                    label: "Add Ingredient"),
                Container(
                  color: TheColors.deepGreen,
                  height: 100.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ingredients"),
                      Text("Qty"),
                    ],
                  ),
                ),
                BlocBuilder<InventoryBloc, InventoryState>(
                    builder: (context, state) {
                  List<Ingredient> inventory = [];
                  if (state is InventoryLoaded) {
                    inventory = state.inventory;
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: inventory.length,
                    itemBuilder: (context, index) {
                      final ingredient = inventory[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(ingredient.name, style: TextStyle(color: TheColors.black),),
                          Text("${ingredient.quantity}", style: TextStyle(color: TheColors.black)),
                        ],
                      );
                    },
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

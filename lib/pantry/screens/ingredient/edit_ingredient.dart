import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/custom_textbox.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/customizations/custom_widgets/pantry_button.dart';
import 'package:my_learning/pantry/blocs/ingredient_bloc/inventory_bloc.dart';
import 'package:my_learning/pantry/custom_widgets/alert_dialog.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/models/ingredient/ingredient_model.dart';
import 'package:my_learning/pantry/models/inventory/inventory.dart';
import 'package:my_learning/pantry/models/inventory/inventory.dart';

class EditIngredient extends StatelessWidget {
  final Ingredient ingredient;

  const EditIngredient({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    final inventoryBloc = BlocProvider.of<InventoryBloc>(context);
    TextEditingController ingredientName =
        TextEditingController(text: ingredient.name);
    TextEditingController quantity =
        TextEditingController(text: ingredient.quantity.toString());
    TextEditingController criticalQty =
        TextEditingController(text: ingredient.criticalQty.toString());
    TextEditingController uOM =
        TextEditingController(text: ingredient.unitOfMeasurement);
    return BlocListener<InventoryBloc, InventoryState>(
      listenWhen: (previous, current) => current is InventoryLoaded,
      listener: (context, state) {
        if (state is InventoryLoaded) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: pantryTheme.scaffoldBackgroundColor,
              leading: IconButton(
                onPressed: () {
                  context.read<InventoryBloc>().add(NavigateBack());
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: pantryTheme.primaryColor,
                ),
                iconSize: 24,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: TheColors.black,
                      ),
                    ),
                    Text(
                      "Ingredient",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 50.sp,
                        color: TheColors.black,
                      ),
                    ),
                    YMargin(30.h),
                    CustomTextbox(
                      label: "Ingredient Name",
                      controller: ingredientName,
                      isReadOnly: true,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Input",
                      suffixIcon: IconButton(
                        onPressed: () {
                          ingredientName.clear();
                        },
                        icon: const Icon(Icons.cancel_outlined),
                      ),
                      borderRadius: 4,
                    ),
                    YMargin(30.h),
                    Row(
                      children: [
                        SizedBox(
                          width: 120.w,
                          child: CustomTextbox(
                            label: "Quantity",
                            controller: quantity,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "Input",
                            suffixIcon: IconButton(
                              onPressed: () {
                                quantity.clear();
                              },
                              icon: const Icon(Icons.cancel_outlined),
                            ),
                            borderRadius: 4,
                          ),
                        ),
                        XMargin(60.w),
                        SizedBox(
                          width: 120.w,
                          child: CustomTextbox(
                            label: "Critical Qty",
                            controller: criticalQty,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "Input",
                            suffixIcon: IconButton(
                              onPressed: () {
                                criticalQty.clear();
                              },
                              icon: const Icon(Icons.cancel_outlined),
                            ),
                            borderRadius: 4,
                          ),
                        ),
                      ],
                    ),
                    YMargin(30.h),
                    CustomTextbox(
                      label: "Unit of Measurement",
                      controller: uOM,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Input",
                      suffixIcon: IconButton(
                        onPressed: () {
                          uOM.clear();
                        },
                        icon: const Icon(Icons.cancel_outlined),
                      ),
                      borderRadius: 4,
                    ),
                    YMargin(100.h),
                    PantryButton(
                      onPressed: () {
                        inventoryBloc.add(EditIngredientEvent(
                              name: ingredientName.text,
                              quantity: quantity.text,
                              criticalQty: criticalQty.text,
                              unitOfMeasurement: uOM.text,
                            ));

                        ingredientName.clear();
                        quantity.clear();
                        criticalQty.clear();
                        uOM.clear();
                      },
                      label: "Edit Ingredient",
                      labelColor: pantryTheme.scaffoldBackgroundColor,
                    ),
                    YMargin(10.h),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
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
                      child: Text("Delete Instead?"),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

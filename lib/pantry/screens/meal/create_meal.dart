import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/custom_textbox.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/customizations/custom_widgets/pantry_button.dart';
import 'package:my_learning/pantry/blocs/bloc/inventory_bloc.dart';
import 'package:my_learning/pantry/blocs/meal_bloc/meal_bloc.dart';
import 'package:my_learning/pantry/custom_widgets/image_selector.dart';
import 'package:my_learning/pantry/custom_widgets/inventory_display_widget.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/models/ingredient/ingredient_model.dart';
import 'package:my_learning/pantry/models/meal/meal_ingredient.dart';

class CreateMeal extends StatelessWidget {
  const CreateMeal({super.key});

  @override
  Widget build(BuildContext context) {
    final mealBloc = BlocProvider.of<MealBloc>(context);
    final inventoryBloc = BlocProvider.of<InventoryBloc>(context);
    final inventoryState = inventoryBloc.state;
    List<Ingredient> inventory = [];
    if (inventoryState is InventoryLoaded) {
      inventory = inventoryState.inventory;
    }
    // List<TextEditingController> quantityControllers = [];
    // List<MealIngredient> selectedIngredient = [];
    bool showError = false;
    return BlocListener<MealBloc, MealState>(
      listener: (context, state) {
        if (state is MealsLoaded) {
          Navigator.pop(context);
        } else {
          showError = true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: pantryTheme.primaryColor,
            ),
          ),
          elevation: 1,
          backgroundColor: pantryTheme.scaffoldBackgroundColor,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create A",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Meal",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 50.sp,
                    ),
                  )
                ],
              ),
              YMargin(60.h),
              BlocBuilder<MealBloc, MealState>(
                builder: (context, state) {
                  final name = TextEditingController(
                    text: state is MealTemplate ? state.name : "",
                  );
                  File? mealImage =
                  state is MealTemplate ? File(state.image ?? "") : null;
                  final selectedIngredients = state is MealTemplate
                      ? state.mealIngredients
                      : <MealIngredient>[];
                  final howToCook = TextEditingController(
                    text: state is MealTemplate ? state.howToCook : "",
                  );
                  final timeToCook = TextEditingController(
                    text: state is MealTemplate ? state.timeToCook : "",
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextbox(
                        label: "Meal Name",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Input",
                        controller: name,
                        suffixIcon: const Icon(Icons.cancel_outlined),
                        borderRadius: 4.r,
                      ),
                      YMargin(24.h),
                      Text(
                        "Add an Image",
                        style: TextStyle(
                          color: TheColors.lightGrey,
                        ),
                      ),
                      YMargin(6.h),
                      mealImage != null
                          ? Slidable(
                        endActionPane: ActionPane(
                          extentRatio: 0.25,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {},
                              backgroundColor: TheColors.deepRed,
                              foregroundColor: TheColors.errorRed,
                              icon: Icons.delete_outline_rounded,
                            ),
                          ],
                        ),
                        child: Image.file(
                          mealImage,
                          height: 100.h,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                      )
                          : ImageSelector(
                        onImageSelected: (File image) {
                          mealBloc.add(
                            GetMealImage(
                                mealImagePath: image.path,
                                name: name.text),
                          );
                        },
                      ),
                      YMargin(24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ingredients",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: TheColors.lightGrey,
                                ),
                              ),
                              Text(
                                "Quantity required for One (1) Serving",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontStyle: FontStyle.italic,
                                  color: TheColors.lightGrey,
                                ),
                              )
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InventoryDisplayWidget(
                                            inventory: inventory,
                                            onTap: (index) {
                                              final ingredient =
                                              inventory[index];
                                              mealBloc.add(AddMealIngredient(
                                                  ingredient: ingredient,
                                                  quantity: 1));
                                              // quantityControllers.add(
                                              //     TextEditingController(
                                              //         text: "1"));
                                              Navigator.pop(context);
                                            },
                                          )));
                            },
                            icon: Icon(
                              Icons.add,
                              size: 36.h,
                              color: pantryTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      YMargin(24.h),
                      selectedIngredients.isNotEmpty
                          ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: selectedIngredients.length,
                        itemBuilder: (context, index) {
                          final mealIngredient =
                          selectedIngredients[index];
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: TheColors.faintGrey,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Text(
                                  mealIngredient.ingredient.name,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        mealBloc.add(
                                            DecrementIngredientQuantity(
                                                ingredient:
                                                mealIngredient));
                                      },
                                      icon: const Icon(
                                        Icons
                                            .remove_circle_outline_rounded,
                                      ),
                                    ),
                                    Text(
                                      mealIngredient.quantity.toString(),
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        mealBloc.add(
                                            IncrementIngredientQuantity(
                                                ingredient:
                                                mealIngredient));
                                      },
                                      icon: Icon(
                                        Icons.add_circle_outline_rounded,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  mealIngredient
                                      .ingredient.unitOfMeasurement,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    selectedIngredients.removeAt(index);
                                    // quantityControllers.removeAt(index);
                                  },
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    color: TheColors.errorRed,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                          : const SizedBox(),
                      YMargin(24.h),
                      CustomTextbox(
                        label: "How to cook",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Input",
                        controller: howToCook,
                        borderRadius: 4.r,
                        suffixIcon: Icon(Icons.cancel_outlined),
                      ),
                      YMargin(24.h),
                      CustomTextbox(
                        label: "Time to cook",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Write only the number of minutes",
                        controller: timeToCook,
                        borderRadius: 4.r,
                        suffixIcon: Icon(Icons.cancel_outlined),
                      ),
                      YMargin(24.h),
                    ],
                  );
                },
              ),
              BlocBuilder<MealBloc, MealState>(
                builder: (context, state) {
                  return PantryButton(
                    onPressed: () {
                      final String mealName = (state as MealTemplate).name;
                      final String image = (state as MealTemplate).image!;
                      final List<MealIngredient> mealIng =
                          (state as MealTemplate).mealIngredients;
                      mealBloc.add(
                        AddMeal(
                          name: mealName,
                          image: image,
                          mealIngredients: mealIng,
                        ),
                      );

                      // name.clear();
                      // howToCook.clear();
                      // timeToCook.clear();
                      // selectedIngredients.clear();

                    },
                    label: "Create Meal",
                    labelColor: pantryTheme.scaffoldBackgroundColor,
                  );
                },
              ),
              BlocBuilder<MealBloc, MealState>(
                builder: (context, state) {
                  String message = "";
                  if (state is MealAddingError) {
                    message = state.message;
                    return showError ? errorRow(message) : SizedBox();
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget errorRow(String message) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.error,
        color: pantryTheme.indicatorColor,
      ),
      Text(message),
    ],
  );
}

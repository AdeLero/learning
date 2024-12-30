import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_learning/pantry/models/meal/meal_model.dart';
import '../../customizations/colors.dart';
import '../../customizations/custom_widgets/margins.dart';
import '../customization/theme_data.dart';
import '../models/ingredient/ingredient_model.dart';

class InventoryDisplayWidget extends StatelessWidget {
  final List<dynamic> inventory;
  final void Function(int index)? leftOnPressed;
  final void Function(int index)? rightOnPressed;
  final void Function(int index)? onTap;
  const InventoryDisplayWidget({super.key, required this.inventory, this.leftOnPressed, this.rightOnPressed, this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isAllIngredients = inventory.every((item) => item is Ingredient);
    bool isAllMeals = inventory.every((item) => item is Meal);
    return Container(
      color: TheColors.white,
      padding: EdgeInsets.all(1.w),
      child: Column(
        children: [
          if (isAllIngredients)
          Container(
            color: TheColors.deepGreen,
            height: 40.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ingredients",
                  style: TextStyle(
                    color: pantryTheme.scaffoldBackgroundColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "Qty",
                  style: TextStyle(
                    color: pantryTheme.scaffoldBackgroundColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          if (isAllIngredients)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w,),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: inventory.length,
              itemBuilder: (context, index) {
                final ingredient = inventory[index];
                return Slidable(
                  key: key,
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.25.w,
                    children: [
                      SlidableAction(
                        onPressed: (context) => leftOnPressed?.call(index),
                        backgroundColor: TheColors.deepGreen,
                        foregroundColor: Colors.white,
                        icon: Icons.edit_outlined,
                      )
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.25.w,
                    children: [
                      SlidableAction(
                        onPressed: (context) => rightOnPressed?.call(index),
                        icon: Icons.delete_rounded,
                        backgroundColor: TheColors.deepRed,
                        foregroundColor: TheColors.errorRed,
                      )
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () => onTap?.call(index),
                    child: Container(
                      height: 40.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: TheColors.black,
                            width: 0.5.w,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ingredient.name,
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(
                            width: 120.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 10.h,
                                  width: 10.w,
                                  decoration: BoxDecoration(
                                    color: TheColors.deepGreen,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                XMargin(30.w),
                                Text(
                                    "${ingredient.quantity} ${ingredient.unitOfMeasurement}",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (isAllMeals)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: inventory.length,
              itemBuilder: (context, index) {
                final meal = inventory[index];
                return Slidable(
                  key: key,
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.25.w,
                    children: [
                      SlidableAction(
                        onPressed: (context) => leftOnPressed?.call(index),
                        backgroundColor: TheColors.deepGreen,
                        foregroundColor: TheColors.lightGreen,
                        icon: Icons.edit_outlined,
                      )
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.25.w,
                    children: [
                      SlidableAction(
                        onPressed: (context) => rightOnPressed?.call(index),
                        icon: Icons.delete_rounded,
                        backgroundColor: TheColors.deepRed,
                        foregroundColor: pantryTheme.indicatorColor,
                      )
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () => onTap?.call(index),
                    child: Stack(
                      children: [
                        meal.image != null
                            ? Image.file(
                          File(meal.image!),
                          height: 150.h,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.darken,
                          color: TheColors.black.withOpacity(0.05),
                        )
                            : Container(
                          height: 150.h,
                          color: TheColors.lightGreen,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20.w,
                              bottom: 15.h,
                            ),
                            child: Text(
                              meal.name,
                              style: TextStyle(
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w900,
                                color: TheColors.white,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 4.r,
                                    color: TheColors.black.withOpacity(0.25),
                                  )
                                ]
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../customizations/colors.dart';
import '../../customizations/custom_widgets/margins.dart';
import '../customization/theme_data.dart';
import '../models/ingredient/ingredient_model.dart';

class InventoryDisplayWidget extends StatelessWidget {
  final List<Ingredient> inventory;
  final void Function(int index)? leftOnPressed;
  final void Function(int index)? rightOnPressed;
  final void Function(int index)? onTap;
  const InventoryDisplayWidget({super.key, required this.inventory, this.leftOnPressed, this.rightOnPressed, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w,),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: inventory.length,
            itemBuilder: (context, index) {
              final ingredient = inventory[index];
              return Slidable(
                key: key,
                startActionPane: ActionPane(
                  motion: ScrollMotion(),
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
                  motion: ScrollMotion(),
                  extentRatio: 0.25.w,
                  children: [
                    SlidableAction(
                      onPressed: (context) => rightOnPressed?.call(index),
                      backgroundColor: TheColors.deepRed,
                      foregroundColor: TheColors.errorRed,
                      icon: Icons.delete,
                    )
                  ],
                ),
                child: GestureDetector(
                  onTap: () => onTap?.call(index),
                  child: Container(
                    height: 50.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
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
                            fontSize: 14,
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
                                    fontSize: 14,
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
      ],
    );
  }
}

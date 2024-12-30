import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/pantry/customization/color_scheme.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/models/meal_time_enum.dart';

class MealtimeSelector extends StatefulWidget {
  final Function(MealTime) onMealTimeSelected;
  const MealtimeSelector({super.key, required this.onMealTimeSelected});

  @override
  State<MealtimeSelector> createState() => _MealtimeSelectorState();
}

class _MealtimeSelectorState extends State<MealtimeSelector> {
  MealTime? selectedMealTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: pantryTheme.scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: MealTime.values.map((mealTime) {
          final bool isSelected = mealTime == selectedMealTime;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedMealTime = mealTime;
              });
              widget.onMealTimeSelected(mealTime);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.h),
              decoration: BoxDecoration(
                color: isSelected ? pantryTheme.primaryColor : pantryScheme.onTertiary,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                mealTime.name.capitalize(),
                style: TextStyle(
                  color: isSelected ? pantryTheme.scaffoldBackgroundColor : pantryTheme.primaryColor,
                  fontSize: 15.sp,
                  fontStyle: FontStyle.italic
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() => "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
}

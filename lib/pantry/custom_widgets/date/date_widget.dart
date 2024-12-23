import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';

class DateWidget extends StatelessWidget {
  final String dayOfWeek;
  final String day;
  final String month;
  final bool isSelected;
  const DateWidget({super.key, required this.dayOfWeek, required this.day, required this.month, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 70.h,
      decoration: BoxDecoration(
        color: isSelected ? pantryTheme.primaryColor : TheColors.tealGreen,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dayOfWeek,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: isSelected ? TheColors.lightGreen : TheColors.deepGreen,
              fontSize: 12.sp,
            ),
          ),
          YMargin(2.h),
          Text(
            day,
            style: TextStyle(
              fontSize: 24.sp,
              color: isSelected ? TheColors.lightGreen : TheColors.deepGreen,
              fontWeight: FontWeight.w900,
            ),
          ),
          YMargin(2.h),
          Text(
            month,
            style: TextStyle(
              fontSize: 12.sp,
              color: isSelected ? TheColors.lightGreen : TheColors.deepGreen,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

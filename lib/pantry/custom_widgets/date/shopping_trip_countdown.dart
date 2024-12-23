import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';

class ShoppingTripCountdown extends StatelessWidget {
  const ShoppingTripCountdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: pantryTheme.primaryColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "You've got",
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
          // TODO Implement the no of days till next shopping trip

          Text(
            "05",
            style: TextStyle(
              fontSize: 40.sp,
              fontWeight: FontWeight.w900,
              color: TheColors.lightGreen,
            ),
          ),

          SizedBox(
            width: 124.w,
            child: Text(
              "Days till your next shopping trip",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

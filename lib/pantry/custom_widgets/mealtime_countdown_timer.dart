import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';

class MealtimeCountdownTimer extends StatelessWidget {
  const MealtimeCountdownTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      padding: const EdgeInsets.all(16),
      color: TheColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              "Next Breakfast in",
            style: TextStyle(
              color: TheColors.lightGreen,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          YMargin(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 90.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: pantryTheme.primaryColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    "11",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 50.sp,
                      color: TheColors.lightGreen,
                    ),
                  ),
                ),
              ),

              Text(
                ":",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 50.sp,
                  color: TheColors.lightGreen,
                ),
              ),

              Container(
                width: 90.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: pantryTheme.primaryColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    "11",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 50.sp,
                      color: TheColors.lightGreen,
                    ),
                  ),
                ),
              ),

              Text(
                ":",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 50.sp,
                  color: TheColors.lightGreen,
                ),
              ),

              Container(
                width: 90.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: pantryTheme.primaryColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    "11",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 50.sp,
                      color: TheColors.lightGreen,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

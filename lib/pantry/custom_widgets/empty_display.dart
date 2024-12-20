import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';

class EmptyDisplay extends StatelessWidget {
  final String imagePath;
  final String text;
  const EmptyDisplay({super.key, required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 230.h,
            width: 230.h,
            child: Image.asset(
              imagePath,
            ),
          ),
          YMargin(10.h),
          Text(
            text
          ),
        ],
      ),
    );
  }
}

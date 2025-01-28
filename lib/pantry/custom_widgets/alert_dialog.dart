import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/custom_widgets/custom_Button.dart';
import 'package:my_learning/customizations/custom_widgets/custom_textbox.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/pantry/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_learning/pantry/customization/color_scheme.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String buttonText;
  final Widget content;
  final Function() onSubmit;

  const MyAlertDialog({
    super.key,
    required this.title,
    required this.buttonText,
    required this.content,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20.sp,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          content,
          YMargin(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                buttonText: "Cancel",
                buttonColor: pantryScheme.error,
              ),
              XMargin(8.w),
              CustomButton(
                onTap: () {
                  onSubmit();
                },
                buttonText: buttonText,
                buttonColor: pantryTheme.primaryColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}

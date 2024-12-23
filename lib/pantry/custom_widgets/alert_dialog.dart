import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/custom_widgets/custom_Button.dart';
import 'package:my_learning/customizations/custom_widgets/custom_textbox.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/pantry/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return AlertDialog(
      title: Text(
        "Reset Your Password",
        style: TextStyle(
          fontSize: 20.sp,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextbox(
            label: "Email",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: "Enter your Email here to reset your password",
            controller: emailController,
            borderRadius: 8.r,
            fillColor: Colors.transparent,
          ),
          YMargin(16.h),
          CustomButton(
            onTap: () async {
              final email = emailController.text;
              if (email.isNotEmpty) {
                BlocProvider.of<AuthBloc>(context).add(
                    ForgotPassword(email: email));
              }
              Navigator.pop(context);
            },
            buttonText: "Reset Password",
            buttonColor: pantryTheme.primaryColor,
          )
        ],
      ),
    );
  }
}

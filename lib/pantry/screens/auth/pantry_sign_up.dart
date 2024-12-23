import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/custom_widgets/custom_textbox.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/customizations/custom_widgets/pantry_button.dart';
import 'package:my_learning/pantry/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/screens/home/landing_page.dart';

class PantrySignUp extends StatelessWidget {
  const PantrySignUp({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController password2Controller = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("lib/assets/images/Pantry_App_Logo.png"),
              YMargin(24.h),
              CustomTextbox(
                label: "Username",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "Username",
                controller: userNameController,
                borderRadius: 8.r,
              ),
              YMargin(30.h),
              CustomTextbox(
                label: "Email",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "Email",
                controller: emailController,
                borderRadius: 8.r,
              ),
              YMargin(30.h),
              CustomTextbox(
                label: "Password",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "Password",
                controller: passwordController,
                borderRadius: 8.r,
                suffixIcon: Icon(CupertinoIcons.eye_slash),
              ),
              Text(
                "Error",
              ),
              YMargin(30.h),
              CustomTextbox(
                label: "Re-enter Password",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "Re-enter Password",
                controller: password2Controller,
                borderRadius: 8.r,
                suffixIcon: Icon(CupertinoIcons.eye_slash),
              ),
              Text(
                "Error",
              ),
              YMargin(30.h),
              PantryButton(
                onPressed: () {
                  if (passwordController.text == password2Controller.text) {
                    final email = emailController.text;
                    final password = passwordController.text;
                    BlocProvider.of<AuthBloc>(context).add(AuthSignedUp(email: email, password: password));
                  } else {
                    throw Exception("Passwords do not match");
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LandingPage(),
                    ),
                  );
                },
                label: "Sign Up",
                labelColor: pantryTheme.scaffoldBackgroundColor,
                borderRadius: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

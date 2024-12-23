import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/custom_textbox.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/customizations/custom_widgets/pantry_button.dart';
import 'package:my_learning/pantry/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_learning/pantry/custom_widgets/error_row.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/screens/auth/pantry_sign_in.dart';
import 'package:my_learning/pantry/screens/home/landing_page.dart';

class PantrySignUp extends StatefulWidget {
  const PantrySignUp({super.key});

  @override
  State<PantrySignUp> createState() => _PantrySignUpState();
}

class _PantrySignUpState extends State<PantrySignUp> {
  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController password2Controller = TextEditingController();
    String? localError;
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LandingPage(),
              ),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Column(
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
                      suffixIcon: const Icon(CupertinoIcons.eye_slash),
                    ),
                    if (localError != null)
                     ErrorRow(message: localError!),
                    YMargin(30.h),
                    CustomTextbox(
                      label: "Re-enter Password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Re-enter Password",
                      controller: password2Controller,
                      borderRadius: 8.r,
                      suffixIcon: const Icon(CupertinoIcons.eye_slash),
                    ),
                    if (localError != null)
                      ErrorRow(message: localError!),
                    YMargin(30.h),
                    PantryButton(
                      onPressed: () {
                        if (passwordController.text ==
                            password2Controller.text) {
                          final email = emailController.text;
                          final password = passwordController.text;
                          BlocProvider.of<AuthBloc>(context).add(AuthSignedUp(
                              email: email, password: password));
                        } else {
                          setState(() {
                            localError = "Passwords do not match";
                          });
                          throw Exception("Passwords do not match");
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LandingPage(),
                          ),
                        );
                      },
                      label: "Sign Up",
                      labelColor: pantryTheme.scaffoldBackgroundColor,
                      borderRadius: 8,
                    ),
                    YMargin(8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an Account?",
                          style: TextStyle(
                            color: TheColors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PantrySignIn(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: TheColors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

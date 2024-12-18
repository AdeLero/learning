import 'package:flutter/material.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/custom_Button.dart';
import 'package:my_learning/customizations/custom_widgets/custom_textbox.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.deepPurple,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.topRight,
                child: CustomButton(
                  onTap: () {},
                  isOutlined: true,
                  verticalPadding: 10,
                  horizontalPadding: 10,
                  outlineColor: TheColors.red,
                  outlineThickness: 5,
                  buttonText: 'Sign Up',
                  buttonColor: Colors.transparent,
                  buttonTextStyle: TextStyle(
                    color: TheColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            YMargin(40),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: 370,
              child: Text(
                'Welcome to Pebble Pharmacy',
                style: TextStyle(
                  color: TheColors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 40,
                ),
              ),
            ),
            YMargin(25),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 35),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: TheColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(31),
                    topRight: Radius.circular(31),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Login to your Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    YMargin(50),
                    CustomTextbox(
                      prefixIcon: Icons.person,
                      hasOutline: false,
                      prefixIconColor: TheColors.grey,
                      hintText: 'Username',
                      fillColor: TheColors.lightIndigo,
                      borderRadius: 10,
                    ),
                    YMargin(50),
                    CustomTextbox(
                      prefixIcon: Icons.lock_rounded,
                      hasOutline: false,
                      prefixIconColor: TheColors.grey,
                      hintText: 'Password',
                      suffixIcon: Icon(Icons.remove_red_eye_outlined),
                      suffixIconColor: TheColors.grey,
                      fillColor: TheColors.lightIndigo,
                      borderRadius: 10,
                    ),
                    YMargin(50),
                    CustomButton(
                      onTap: () {},
                      buttonColor: TheColors.deepPurple,
                      buttonText: 'Log In',
                      verticalPadding: 8,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

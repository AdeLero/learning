import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/custom_textbox.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/customizations/custom_widgets/pantry_button.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/screens/auth/pantry_sign_up.dart';

class PantrySignIn extends StatelessWidget {
  const PantrySignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 80.h,
              left: 20.w,
              right: 20.w,
            ),
            child: Column(
              children: [
                Image.asset(
                  "lib/assets/images/Pantry_App_Logo.png",
                  height: 110.h,
                ),
                YMargin(100.h),
                Container(
                  height: 322.h,
                  width: 320.w,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    border: Border.all(color: TheColors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextbox(
                        label: "Email",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Email",
                        borderRadius: 8.r,
                      ),
                      YMargin(40.h),
                      CustomTextbox(
                        label: "Password",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Password",
                        borderRadius: 8.r,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.remove_red_eye_outlined,
                            color: TheColors.grey,
                          ),
                        ),
                      ),
                      YMargin(24.h),
                      PantryButton(
                        onPressed: () {},
                        label: "Sign In",
                        labelColor: pantryTheme.scaffoldBackgroundColor,
                        buttonHeight: 40,
                        buttonWidth: double.maxFinite,
                        borderRadius: 8,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: TheColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                YMargin(8.h),
                Text("OR"),
                YMargin(8.h),
                PantryButton(
                  onPressed: () {},
                  label: "Log in with Google",
                  labelColor: TheColors.grey,
                  buttonColor: pantryTheme.scaffoldBackgroundColor,
                  borderRadius: 8,
                  buttonHeight: 50,
                  hasPrefixIcon: true,
                  prefixIcon: Container(
                    child: SvgPicture.asset(
                      "lib/assets/svg/google_svg.svg",
                      height: 25.h,
                      width: 25.h,
                    ),
                  ),
                ),
                YMargin(8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
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
                            builder: (context) => PantrySignUp(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: TheColors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
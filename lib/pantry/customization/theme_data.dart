import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/pantry/customization/color_scheme.dart';

final ThemeData pantryTheme = ThemeData(
  fontFamily: "Inter",
  textTheme: Typography.englishLike2018.apply(
    fontSizeFactor: 1.sp,
    bodyColor: TheColors.black,
    displayColor: TheColors.black,
  ).copyWith(
    bodySmall: TextStyle(fontFamily: "Inter"),
    bodyMedium: TextStyle(fontFamily: "Inter"),
    bodyLarge: TextStyle(fontFamily: "Inter"),
    titleSmall: TextStyle(fontFamily: "Inter"),
    titleMedium: TextStyle(fontFamily: "Inter"),
    titleLarge: TextStyle(fontFamily: "Inter"),
    displaySmall: TextStyle(fontFamily: "Inter"),
    displayMedium: TextStyle(fontFamily: "Inter"),
    displayLarge: TextStyle(fontFamily: "Inter"),
    labelSmall: TextStyle(fontFamily: "Inter"),
    labelMedium: TextStyle(fontFamily: "Inter"),
    labelLarge: TextStyle(fontFamily: "Inter"),
    headlineSmall: TextStyle(fontFamily: "Inter"),
    headlineMedium: TextStyle(fontFamily: "Inter"),
    headlineLarge: TextStyle(fontFamily: "Inter"),
  ),
  primaryColor: TheColors.deepGreen,
  scaffoldBackgroundColor: TheColors.white,
  indicatorColor: TheColors.errorRed,
  colorScheme: pantryScheme,
);
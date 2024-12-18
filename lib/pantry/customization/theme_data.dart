import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';

final ThemeData pantryTheme = ThemeData(
  fontFamily: "Inter",
  textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
  primaryColor: TheColors.deepGreen,
  // scaffoldBackgroundColor: TheColors.white,
  indicatorColor: TheColors.errorRed,

);
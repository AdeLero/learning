import 'package:flutter/material.dart';
import 'package:my_learning/customizations/colors.dart';

class CustomTextbox extends StatelessWidget {
  final bool hasOutline;
  final bool expands;
  final int? maxLength;
  final double? borderRadius;
  final bool isFilled;
  final Color? fillColor;
  final Color? focusedBorderColor;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final double? prefixIconSize;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final TextEditingController? controller;
  const CustomTextbox({
    this.hasOutline = true,
    this.expands = false,
    this.maxLength,
    this.borderRadius,
    this.isFilled = true,
    this.fillColor,
    this.focusedBorderColor,
    this.hintText,
    this.hintTextStyle,
    this.prefixIcon,
    this.prefixIconColor,
    this.prefixIconSize,
    this.suffixIcon,
    this.suffixIconColor,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      expands: expands,
      maxLength: maxLength,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintTextStyle ??
            TextStyle(
              color: TheColors.grey,
            ),
        prefixIcon: Icon(
          prefixIcon,
          size: prefixIconSize,
        ),
        prefixIconColor: prefixIconColor,
        suffixIcon: Icon(suffixIcon),
        suffixIconColor: suffixIconColor,
        filled: isFilled,
        fillColor: fillColor ?? TheColors.white,
        focusedBorder: hasOutline
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100),
                borderSide: BorderSide(
                  color: focusedBorderColor ?? TheColors.black,
                ),
              )
            : UnderlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100),
                borderSide: BorderSide.none,
              ),
        border: hasOutline
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100),
              )
            : UnderlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 100),
                borderSide: BorderSide.none,
              ),
      ),
    );
  }
}
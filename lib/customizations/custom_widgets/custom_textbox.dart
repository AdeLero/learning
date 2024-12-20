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
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final TextEditingController? controller;
  final String? label;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool hasPrefixIcon;
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
    this.label,
    this.floatingLabelBehavior,
    this.hasPrefixIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      expands: expands,
      maxLength: maxLength,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: floatingLabelBehavior,
        hintText: hintText,
        hintStyle: hintTextStyle ??
            TextStyle(
              color: TheColors.grey,
            ),
        prefixIcon: hasPrefixIcon ? Icon(
          prefixIcon,
          size: prefixIconSize,
        ) : null,
        prefixIconColor: prefixIconColor,
        suffixIcon: suffixIcon,
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

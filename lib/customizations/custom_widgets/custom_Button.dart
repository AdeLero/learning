import 'package:flutter/material.dart';
import 'package:my_learning/customizations/colors.dart';

class CustomButton extends StatelessWidget {
  final void Function() onTap;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Color? buttonColor;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final double? prefixIconSize;
  final String? buttonText;
  final Color? buttonTextColor;
  final TextStyle? buttonTextStyle;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final bool isOutlined;
  final Color? outlineColor;
  final double? outlineThickness;
  final double? borderRadius;
  const CustomButton({
    required this.onTap,
    this.verticalPadding,
    this.horizontalPadding,
    this.buttonColor,
    this.prefixIcon,
    this.prefixIconColor,
    this.prefixIconSize,
    this.buttonText,
    this.buttonTextColor,
    this.buttonTextStyle,
    this.suffixIcon,
    this.suffixIconColor,
    this.isOutlined = false,
    this.outlineColor,
    this.outlineThickness,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding ?? 10 , horizontal: horizontalPadding ?? 20),
        decoration: isOutlined ? BoxDecoration(
          color: buttonColor ?? TheColors.black,
          borderRadius: BorderRadius.circular(borderRadius ?? 100),
          border: Border.all(
            color: outlineColor ?? TheColors.white,
            width: outlineThickness ?? 1,
          ),
        ) : BoxDecoration(
          color: buttonColor ?? TheColors.black,
          borderRadius: BorderRadius.circular( borderRadius ?? 100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon !=null)
            Icon(
              prefixIcon,
              color: prefixIconColor,
              size: prefixIconSize,
            ),
            if (buttonText !=null)
            Text(
              buttonText!,
              style: buttonTextStyle ?? TextStyle(
                color: buttonTextColor ?? TheColors.white,
              ),
            ),
            if (suffixIcon !=null)
            Icon(
              suffixIcon,
              color: suffixIconColor,
            ),
          ],
        ),
      ),
    );
  }
}



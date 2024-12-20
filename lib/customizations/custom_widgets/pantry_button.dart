import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';

class PantryButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? borderRadius;
  final Color? labelColor;
  final Color? buttonColor;
  final bool hasPrefixIcon;
  final Widget? prefixIcon;
  const PantryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.buttonWidth,
    this.buttonHeight,
    this.borderRadius,
    this.labelColor,
    this.buttonColor,
    this.hasPrefixIcon = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: hasPrefixIcon ? Row(
        children: [
          prefixIcon ?? CircleAvatar(),
          XMargin(8.w),
          Text(
            label,
            style: TextStyle(
              color: labelColor ?? TheColors.black,
            ),
          ),
        ],
      ) : Text(
        label,
        style: TextStyle(
          color: labelColor ?? TheColors.black,
        ),
      ),
      style: ButtonStyle(
        foregroundColor:
            WidgetStatePropertyAll(pantryTheme.scaffoldBackgroundColor),
        backgroundColor: WidgetStatePropertyAll(buttonColor ?? pantryTheme.primaryColor),
        fixedSize: WidgetStatePropertyAll(
          Size(buttonWidth ?? 320, buttonHeight ?? 40),
        ),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 20),
          )
        )
      ),
    );
  }
}

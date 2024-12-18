import 'package:flutter/material.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';

class PantryButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final double? buttonWidth;
  final double? buttonHeight;
  const PantryButton({
    super.key,
    required this.onPressed,
    required this.label, this.buttonWidth, this.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
      ),
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(pantryTheme.scaffoldBackgroundColor),
        backgroundColor: WidgetStatePropertyAll(pantryTheme.primaryColor),
        fixedSize: WidgetStatePropertyAll(
          Size(buttonWidth ?? 320, buttonHeight ?? 40),
        ),
      ),
    );
  }
}

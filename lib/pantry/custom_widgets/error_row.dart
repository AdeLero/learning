import 'package:flutter/material.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';

class ErrorRow extends StatelessWidget {
  final String message;
  const ErrorRow({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: pantryTheme.indicatorColor,
          ),
          Text(message),
        ],
      );
    }
  }


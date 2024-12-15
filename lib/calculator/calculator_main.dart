import 'package:flutter/material.dart';
import 'package:my_learning/calculator/Screens/calculator_screen.dart';

void main() {runApp(Calculator());}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

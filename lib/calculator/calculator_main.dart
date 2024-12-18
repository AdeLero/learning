import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning/calculator/Screens/calculator_screen.dart';
import 'package:my_learning/calculator/hydrated_bloc/calculator_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (_) => CalculatorBloc(),
    child: const Calculator(),
  ));
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CalculatorScreen(),
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}

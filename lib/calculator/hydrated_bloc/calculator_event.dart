part of 'calculator_bloc.dart';

@immutable
sealed class CalculatorEvent {}

class CalculatorInput extends CalculatorEvent {
  final String firstNumber;

  CalculatorInput({required this.firstNumber});
}

class CalculateOperation extends CalculatorEvent {
  final String operator;

  CalculateOperation({required this.operator});
}

class ClearCalculator extends CalculatorEvent {}

class DoCalculation extends CalculatorEvent {}

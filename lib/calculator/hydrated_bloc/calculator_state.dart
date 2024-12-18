part of 'calculator_bloc.dart';

@immutable
sealed class CalculatorState {}

final class CalculatorInitial extends CalculatorState {
  final String display;

  CalculatorInitial({this.display = "0"});

}

final class CalculatorTyping extends CalculatorState {
  final String input;

  CalculatorTyping({required this.input});
}

class CalculatorLoading extends CalculatorState {}

class CalculationComplete extends CalculatorState {
  final String result;

  CalculationComplete({required this.result});
}

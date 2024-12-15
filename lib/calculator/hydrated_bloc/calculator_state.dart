part of 'calculator_bloc.dart';

@immutable
sealed class CalculatorState {}

final class CalculatorInitial extends CalculatorState {}

class CalculatorLoading extends CalculatorState {}

class CalculatorSuccess extends CalculatorState {}

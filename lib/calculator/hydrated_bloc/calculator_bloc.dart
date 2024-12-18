import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  String userInput = "";
  String operand = "";
  double? firstNumber;
  CalculatorBloc() : super(CalculatorInitial()) {
    on<CalculateOperation>(calculateOperation);
    on<CalculatorInput>(calculatorInput);
    on<DoCalculation>(doCalculation);
  }

  void calculatorInput(CalculatorInput event, Emitter<CalculatorState> emit) {
    userInput += event.firstNumber;
    print("User input : $userInput");
    print("state: $state");
    emit(CalculatorTyping(input: userInput));
    print("new state: $state");
  }

  void calculateOperation(
      CalculateOperation event, Emitter<CalculatorState> emit) {
    if (userInput.isNotEmpty) {
      firstNumber = double.tryParse(userInput);
      operand = event.operator;
      userInput = "";
      print("User input : $operand");
      emit(CalculatorTyping(input: "$firstNumber $operand"));
    } else {
      return;
    }
  }

  void doCalculation(DoCalculation event, Emitter<CalculatorState> emit) {
    if (userInput.isNotEmpty) {
      double? secondNumber = double.tryParse(userInput);

      if (secondNumber != null) {
        double result;
        try {
          switch (operand) {
            case "+":
              result = firstNumber! + secondNumber;
              break;
            case "-":
              result = firstNumber! - secondNumber;
              break;
            case "*":
              result = firstNumber! * secondNumber;
              break;
            case "/":
              result = firstNumber! / secondNumber;
              break;
            default:
              throw Exception('Unknown Operation');
          }
          print("User input : $result");
          emit(CalculationComplete(result: result.toString()));
        } catch (e) {
          e.toString();
        } finally {
          userInput = "";
          operand = "";
          firstNumber = null;
        }
      } else {
        return;
      }
    } else {
      return;
    }
  }
}

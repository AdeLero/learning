import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends HydratedBloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorInitial()) {
    on<CalculatorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  @override
  CalculatorState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(CalculatorState state) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
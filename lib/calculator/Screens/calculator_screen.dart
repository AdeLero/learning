import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning/calculator/hydrated_bloc/calculator_bloc.dart';
import 'package:my_learning/customizations/custom_widgets/custom_Button.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CalculatorBloc>(context);
    return BlocProvider(
      create: (context) => CalculatorBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<CalculatorBloc, CalculatorState>(
                bloc: bloc,
                builder: (context, state) {
                  String display = "1";
                  if (state is CalculatorInitial) {
                    display = state.display;
                  } else if (state is CalculatorTyping) {
                    display = state.input;
                  } else if (state is CalculationComplete) {
                    display = state.result;
                  }
                  return Container(
                    height: 150,
                    padding: const EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        display,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 80,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          onTap: () {
                            bloc.add(CalculatorInput(firstNumber: "1"));
                          },
                          buttonText: "1",
                          buttonColor: CupertinoColors.activeBlue,
                          borderRadius: 10,
                        ),
                        CustomButton(
                          onTap: () {
                            bloc.add(CalculatorInput(firstNumber: "2"));
                          },
                          buttonText: "2",
                          buttonColor: CupertinoColors.activeBlue,
                          borderRadius: 10,
                        ),
                        CustomButton(
                          onTap: () {
                            bloc.add(CalculatorInput(firstNumber: "3"));
                          },
                          buttonText: "3",
                          buttonColor: CupertinoColors.activeBlue,
                          borderRadius: 10,
                        ),
                        CustomButton(
                          onTap: () {
                            bloc.add(CalculateOperation(operator: "+"));
                          },
                          buttonText: "+",
                          buttonColor: CupertinoColors.activeBlue,
                          borderRadius: 10,
                        ),
                      ],
                    ),
                    YMargin(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          onTap: () {
                            bloc.add(CalculatorInput(firstNumber: "4"));
                          },
                          buttonText: "4",
                          buttonColor: CupertinoColors.activeBlue,
                          borderRadius: 10,
                        ),
                        CustomButton(
                          onTap: () {
                            bloc.add(CalculatorInput(firstNumber: "5"));
                          },
                          buttonText: "5",
                          buttonColor: CupertinoColors.activeBlue,
                          borderRadius: 10,
                        ),
                        CustomButton(
                          onTap: () {
                            bloc.add(CalculatorInput(firstNumber: "6"));
                          },
                          buttonText: "6",
                          buttonColor: CupertinoColors.activeBlue,
                          borderRadius: 10,
                        ),
                        CustomButton(
                          onTap: () {
                            bloc.add(CalculateOperation(operator: "-"));
                          },
                          buttonText: "-",
                          buttonColor: CupertinoColors.activeBlue,
                          borderRadius: 10,
                        ),
                      ],
                    ),
                    YMargin(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          onTap: () {
                            bloc.add(CalculatorInput(firstNumber: "7"));
                          },
                          buttonText: "7",
                          buttonColor: CupertinoColors.activeBlue,
                          borderRadius: 10,
                        ),
                        CustomButton(
                          onTap: () {
                            bloc.add(CalculatorInput(firstNumber: "8"));
                          },
                          buttonText: "8",
                          buttonColor: CupertinoColors.activeBlue,
                          borderRadius: 10,
                        ),
                        CustomButton(
                          onTap: () {
                            bloc.add(CalculatorInput(firstNumber: "9"));
                          },
                          buttonText: "9",
                          buttonColor: CupertinoColors.activeBlue,
                          borderRadius: 10,
                        ),
                        CustomButton(
                          onTap: () {
                            bloc.add(CalculateOperation(operator: "*"));
                          },
                          buttonText: "*",
                          buttonColor: CupertinoColors.activeBlue,
                          borderRadius: 10,
                        ),
                      ],
                    ),
                    YMargin(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          onTap: () {
                            bloc.add(CalculatorInput(firstNumber: "0"));
                          },
                          buttonText: "0",
                          buttonColor: CupertinoColors.activeBlue,
                          borderRadius: 10,
                        ),
                        CustomButton(
                          onTap: () {
                            bloc.add(CalculateOperation(operator: "/"));
                          },
                          buttonText: "/",
                          buttonColor: CupertinoColors.activeBlue,
                          borderRadius: 10,
                        ),
                        CustomButton(
                          onTap: () {
                            bloc.add(DoCalculation());
                          },
                          buttonText: "=",
                          buttonColor: CupertinoColors.activeBlue,
                          borderRadius: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

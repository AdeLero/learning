import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/pantry/blocs/trip_bloc/trip_bloc.dart';
import 'package:my_learning/pantry/blocs/trip_bloc/trip_bloc.dart';
import 'package:my_learning/pantry/routes/routes.dart';

class LoadingScreen extends StatelessWidget {

  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TripBloc, TripState>(
      listener: (context, state) {
        if (state is TripListGenerated) {
          Navigator.pushReplacementNamed(context, Routes.confirmationScreen, arguments: state.shoppingList);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              YMargin(20.h),
              Text(
                "Generating Shopping List",
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

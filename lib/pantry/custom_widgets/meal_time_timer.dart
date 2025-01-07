import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/pantry/blocs/meal_time_bloc/meal_time_bloc.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/models/meal_time_enum.dart';

class MealTimeTimerWidget extends StatelessWidget {
  const MealTimeTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealTimeBloc, MealTimeState>(
      builder: (context, state) {
        if (state is CountingDown) {
          final mealTime = state.mealTime;

          return StreamBuilder<Duration>(
            stream: context.read<MealTimeBloc>().timerStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final Duration timeRemaining = snapshot.data!;
                final hours = timeRemaining.inHours.toString().padLeft(2, '0');
                final minutes =
                    (timeRemaining.inMinutes % 60).toString().padLeft(2, '0');
                final seconds =
                    (timeRemaining.inSeconds % 60).toString().padLeft(2, '0');
                final color = timeRemaining.inSeconds <= 60
                    ? TheColors.errorRed
                    : TheColors.lightGreen;
                final background = timeRemaining.inSeconds <= 60
                    ? TheColors.deepRed
                    : TheColors.deepGreen;

                return Container(
                  height: 150.h,
                  padding: const EdgeInsets.all(16),
                  color: TheColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Next ${mealTime.displayName} in",
                        style: TextStyle(
                          color: TheColors.shadedGreen,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      YMargin(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90.w,
                            height: 70.h,
                            decoration: BoxDecoration(
                              color: background,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                hours,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 50.sp,
                                  color: color,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 50.sp,
                              color: color,
                            ),
                          ),
                          Container(
                            width: 90.w,
                            height: 70.h,
                            decoration: BoxDecoration(
                              color: background,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                minutes,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 50.sp,
                                  color: color,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 50.sp,
                              color: color,
                            ),
                          ),
                          Container(
                            width: 90.w,
                            height: 70.h,
                            decoration: BoxDecoration(
                              color: background,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                seconds,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 50.sp,
                                  color: color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        } else if (state is MealTimeUpdated) {
          return const Center(
            child: Text(
              "No active countdown",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        } else if (state is MealTimeUpdateError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

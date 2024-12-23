import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/pantry_button.dart';
import 'package:my_learning/pantry/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_learning/pantry/blocs/bloc/inventory_bloc.dart';
import 'package:my_learning/pantry/custom_widgets/date/date_selector.dart';
import 'package:my_learning/pantry/custom_widgets/date/shopping_trip_countdown.dart';
import 'package:my_learning/pantry/custom_widgets/empty_display.dart';
import 'package:my_learning/pantry/custom_widgets/inventory_display_widget.dart';
import 'package:my_learning/pantry/custom_widgets/mealtime_countdown_timer.dart';
import 'package:my_learning/pantry/custom_widgets/planned_meal_display.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<InventoryBloc, InventoryState>(
                  builder: (context, state) {
                    if (state is InventoryLoaded) {
                      return Padding(
                        padding: EdgeInsets.only(left:20.w, right: 20.w, top: 20.h),
                        child: DateSelector(
                          onDateTapped: () {
                            // TODO Implement the UI change on the buttons when they are selected

                            // TODO Implement the changing of the UI to show only meals that are planned for the said date
                          },
                          daysToGenerate: 5,
                        ),
                      );
                    }
                    return const SizedBox();
                  }
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  String? userName = "Username";
                  if (state is Authenticated) {
                    final user = state.user;
                    userName = user.displayName;
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 16.h),
                    child: Text(
                      userName ?? "Username",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: pantryTheme.primaryColor,
                      ),
                    ),
                  );
                },
              ),
              const MealtimeCountdownTimer(),
              const PlannedMealDisplay(),
              BlocBuilder<InventoryBloc, InventoryState>(
                builder: (context, state) {
                  if (state is InventoryLoaded &&
                      state.inventory.isNotEmpty) {
                    final inventory = state.inventory;
                    return InventoryDisplayWidget(
                      inventory: inventory,
                    );
                  } else if (state is InventoryInitial) {
                    return const EmptyDisplay(
                        imagePath: "lib/assets/images/no_scheduled_meals.png",
                        text: "You Have not Planned Any Meals");
                  }
                  return Container();
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    PantryButton(
                        onPressed: () {},
                        label: "Plan A Shopping Trip",
                      borderRadius: 8,
                      labelColor: TheColors.white,
                    ),
                    const ShoppingTripCountdown(),
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

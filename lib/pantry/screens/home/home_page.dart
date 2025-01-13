import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/pantry_button.dart';
import 'package:my_learning/pantry/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_learning/pantry/blocs/ingredient_bloc/inventory_bloc.dart';
import 'package:my_learning/pantry/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:my_learning/pantry/custom_widgets/date/date_selector.dart';
import 'package:my_learning/pantry/custom_widgets/date/shopping_trip_countdown.dart';
import 'package:my_learning/pantry/custom_widgets/empty_display.dart';
import 'package:my_learning/pantry/custom_widgets/inventory_display_widget.dart';
import 'package:my_learning/pantry/custom_widgets/meal_time_timer.dart';
import 'package:my_learning/pantry/custom_widgets/planned_meal_display.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/models/meal_time_enum.dart';
import 'package:my_learning/pantry/routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();
  DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  int selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    final scheduleBloc = context.read<ScheduleBloc>();
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
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                    child: DateSelector(
                      onDateTapped: (date) {
                        setState(() {
                          final startDate = DateTime.now().subtract(const Duration(days: 3));
                          selectedDate = date;
                          selectedIndex =
                              date.difference(startDate).inDays;
                        });
                      },
                      selectedIndex: selectedIndex,
                      daysToGenerate: 5,
                    ),
                  );
                }
                return const SizedBox();
              }),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  String? userName = "Username";
                  if (state is Authenticated) {
                    final user = state.user;
                    userName = user.displayName;
                  }
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
              const MealTimeTimerWidget(),
              BlocBuilder<ScheduleBloc, ScheduleState>(
                builder: (context, state) {
                  if (state is ScheduledMealComplete) {
                    final today = normalizeDate(selectedDate);
                    final todaysSchedule = state.scheduledMeals
                        .where((meal) => normalizeDate(meal.date) == today)
                        .toList()
                    ..sort((a,b) => a.timeStamp.compareTo(b.timeStamp));

                    return todaysSchedule.isNotEmpty
                        ? ListView.builder(
                            itemCount: todaysSchedule.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final meal = todaysSchedule[index];
                              return PlannedMealDisplay(
                                mealName: meal.meal.name,
                                mealTime: meal.mealTime.displayName,
                                timeStamp: meal.timeStamp,
                                mealImage: meal.meal.image!,
                                mealServings: meal.servings.toString(),
                                onEdit: () {
                                  Navigator.pushNamed(
                                      context, Routes.editScheduledMeal,
                                      arguments: meal.id);
                                },
                                onDelete: () {
                                  scheduleBloc
                                      .add(DeleteMealFromSchedule(id: meal.id));
                                },
                                onShare: () {},
                                onFavorite: () {},
                              );
                            },
                          )
                        : const EmptyDisplay(
                            imagePath:
                                "lib/assets/images/no_scheduled_meals.png",
                            text: "No meals Planned for this day",
                          );
                  }
                  return const SizedBox();
                },
              ),
              BlocBuilder<InventoryBloc, InventoryState>(
                builder: (context, state) {
                  if (state is InventoryLoaded && state.inventory.isNotEmpty) {
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

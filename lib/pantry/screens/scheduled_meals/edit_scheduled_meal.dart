import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/customizations/custom_widgets/pantry_button.dart';
import 'package:my_learning/pantry/blocs/meal_bloc/meal_bloc.dart';
import 'package:my_learning/pantry/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:my_learning/pantry/custom_widgets/alert_dialog.dart';
import 'package:my_learning/pantry/custom_widgets/calendar.dart';
import 'package:my_learning/pantry/custom_widgets/inventory_display_widget.dart';
import 'package:my_learning/pantry/custom_widgets/mealtime_selector.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';

class EditScheduledMeal extends StatefulWidget {
  final String scheduledMealId;
  const EditScheduledMeal({super.key, required this.scheduledMealId});

  @override
  State<EditScheduledMeal> createState() => _EditScheduledMealState();
}

class _EditScheduledMealState extends State<EditScheduledMeal> {

  @override
  void initState() {
    super.initState();
    final scheduleBloc = context.read<ScheduleBloc>();
    final scheduledMeal = scheduleBloc.scheduledMeals.firstWhere((item) => item.id == widget.scheduledMealId);
    scheduleBloc.add(GetMealTime(mealTime: scheduledMeal.mealTime));
    scheduleBloc.add(GetMeal(meal: scheduledMeal.meal));
    scheduleBloc.add(GetDate(date: scheduledMeal.date));
    scheduleBloc.add(UpdateServings(servings: scheduledMeal.servings));
  }

  @override
  Widget build(BuildContext context) {
    final scheduleBloc = context.read<ScheduleBloc>();
    final mealBloc = BlocProvider.of<MealBloc>(context);
    final mealState = mealBloc.state;
    final inventory = (mealState as MealsLoaded).meals;
    return BlocListener<ScheduleBloc, ScheduleState>(
      listenWhen: (previous, current) => current is ScheduleBeingFilled,
      listener: (context, state) {
        if (state is ScheduledMealComplete) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              leading: IconButton(
                onPressed: () {
                  scheduleBloc.add(NavigateScheduleBack());
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 24.w,
                  color: pantryTheme.primaryColor,
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Schedule A",
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                "Meal",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 50.sp,
                                ),
                              ),
                              YMargin(24.h),
                              Text(
                                "What time is the Meal?",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                              YMargin(8.h),
                              MealtimeSelector(
                                onMealTimeSelected: (mealTime) {
                                  scheduleBloc
                                      .add(GetMealTime(mealTime: mealTime));
                                },
                              ),
                              YMargin(24.h),
                              Text(
                                "What Meal is it?",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                              YMargin(8.h),
                              state is ScheduleBeingFilled && state.meal != null
                                  ? Slidable(
                                endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    extentRatio: 0.25,
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return MyAlertDialog(
                                                    title:
                                                    "Delete Meal",
                                                    buttonText:
                                                    "Delete",
                                                    content: Text(
                                                        "Are you sure you want to delete ${state.meal?.name}?"),
                                                    onSubmit: () {
                                                      scheduleBloc.add(
                                                          DeletePendingMeal());
                                                    });
                                              });
                                        },
                                        icon:
                                        Icons.delete_outline_outlined,
                                      ),
                                    ]),
                                child: Image.file(
                                  File(state.meal!.image!),
                                  width: double.maxFinite,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : GestureDetector(
                                child: Container(
                                  width: double.maxFinite,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: pantryTheme.primaryColor,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 48.h,
                                    color: pantryTheme.primaryColor,
                                  ),
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.r),
                                            topRight:
                                            Radius.circular(8.r),
                                          ),
                                          child: InventoryDisplayWidget(
                                            inventory: inventory,
                                            onTap: (index) {
                                              final meal =
                                              inventory[index];
                                              scheduleBloc.add(GetMeal(meal: meal));
                                              Navigator.pop(context);
                                            },
                                          ),
                                        );
                                      });
                                },
                              ),
                              YMargin(24.h),
                              Text(
                                "What Day?",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                              YMargin(8.h),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Calendar(
                                                onDaySelected: (date) {
                                                  if (date != null) {
                                                    scheduleBloc
                                                        .add(GetDate(date: date));
                                                    print("meal date: $date");
                                                    Navigator.pop(context);
                                                  }
                                                });
                                          });
                                    },
                                    icon: const Icon(
                                        Icons.calendar_today_outlined),
                                  ),
                                  Text(
                                    state is ScheduleBeingFilled &&
                                        state.date != null
                                        ? DateFormat('dd/MM/yyyy (E)')
                                        .format(state.date!)
                                        : DateFormat('dd/MM/yyyy (E)')
                                        .format(DateTime.now()),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                              YMargin(24.h),
                              Text(
                                "How Many Servings?",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                              YMargin(8.h),
                              if (state is ScheduleBeingFilled)
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        scheduleBloc.add(UpdateServings(
                                            servings: state.servings - 1));
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle_outline_rounded,
                                      ),
                                    ),
                                    Text(
                                      "${state.servings}",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        scheduleBloc.add(UpdateServings(
                                            servings: state.servings + 1));
                                      },
                                      icon: const Icon(
                                        Icons.add_circle_outline_rounded,
                                      ),
                                    ),
                                  ],
                                ),
                              YMargin(24.h),
                            ],
                          ),
                        ),
                        Container(
                          color: pantryTheme.scaffoldBackgroundColor,
                          child: Column(
                            children: [
                              Container(
                                height: 40.h,
                                width: double.maxFinite,
                                color: pantryTheme.primaryColor,
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Ingredients",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        color:
                                        pantryTheme.scaffoldBackgroundColor,
                                      ),
                                    ),
                                    Text(
                                      "Qty",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        color:
                                        pantryTheme.scaffoldBackgroundColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              state is ScheduleBeingFilled && state.meal != null
                                  ? ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                state.meal?.mealIngredients.length,
                                itemBuilder: (context, index) {
                                  final mealIngredient =
                                  state.meal?.mealIngredients[index];
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24.w),
                                    height: 24.h,
                                    color: pantryTheme
                                        .scaffoldBackgroundColor,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          mealIngredient!.ingredient.name,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        Text(
                                          "${mealIngredient.quantity * state.servings} ${mealIngredient.ingredient.unitOfMeasurement}",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PantryButton(
                  onPressed: () {
                    if (state is ScheduleBeingFilled) {
                      final t = state;
                      scheduleBloc.add(EditAScheduledMeal(
                        id: widget.scheduledMealId,
                        mealTime: t.mealTime!,
                        meal: t.meal!,
                        date: t.date!,
                        servings: t.servings,
                      ));
                    }
                  },
                  label: "Schedule Meal",
                  labelColor: pantryTheme.scaffoldBackgroundColor,
                ),
                YMargin(24.h),
              ],
            ),
          );
        },
      ),
    );
  }
}

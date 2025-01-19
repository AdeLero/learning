import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/pantry/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:my_learning/pantry/custom_widgets/alert_dialog.dart';
import 'package:my_learning/pantry/models/scheduled_meals/meal_prep_enum.dart';

class PlannedMealDisplay extends StatefulWidget {
  final String mealTime;
  final String mealName;
  final String mealImage;
  final String mealServings;
  final DateTime timeStamp;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onShare;
  final VoidCallback onFavorite;
  final String id;
  final MealPrep? mealPrep;

  const PlannedMealDisplay({
    super.key,
    required this.mealTime,
    required this.mealName,
    required this.onEdit,
    required this.onDelete,
    required this.onShare,
    required this.onFavorite,
    required this.mealImage,
    required this.mealServings,
    required this.timeStamp,
    required this.id,
    this.mealPrep,
  });

  @override
  State<PlannedMealDisplay> createState() => _PlannedMealDisplayState();
}

class _PlannedMealDisplayState extends State<PlannedMealDisplay> {
  @override
  Widget build(BuildContext context) {
    bool isCooked = widget.mealPrep == MealPrep.cooked;
    bool isOrdered = widget.mealPrep == MealPrep.ordered;
    DateTime now = DateTime.now();
    bool isPassed = widget.timeStamp.isBefore(now);
    final scheduleBloc = context.read<ScheduleBloc>();
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        return Slidable(
          startActionPane: ActionPane(
              extentRatio: 0.25,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) => widget.onEdit(),
                  backgroundColor: TheColors.deepGreen,
                  foregroundColor: TheColors.lightGreen,
                  icon: Icons.edit_outlined,
                ),
              ]),
          endActionPane: ActionPane(
              extentRatio: 0.25,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return MyAlertDialog(
                            title: "Delete From Schedule",
                            buttonText: "Delete",
                            content: const Text(
                              "Are you sure you want to delete from schedule?",
                            ),
                            onSubmit: widget.onDelete,
                          );
                        });
                  },
                  icon: Icons.delete_outline_rounded,
                ),
              ]),
          child: Stack(
            children: [
              widget.mealImage.isNotEmpty
                  ? isPassed
                      ? Stack(
                          children: [
                            Image.file(
                              File(widget.mealImage),
                              height: 200.h,
                              width: double.maxFinite,
                              fit: BoxFit.cover,
                              color: TheColors.black.withOpacity(0.5),
                              colorBlendMode: BlendMode.colorBurn,
                            ),
                            Positioned.fill(
                              child: Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          if (!isOrdered)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                onPressed: isCooked
                                                    ? () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                MyAlertDialog(
                                                                  title:
                                                                      "Change?",
                                                                  buttonText:
                                                                      "Yes",
                                                                  content:
                                                                      const Text(
                                                                          "Are you sure you want to cancel Cooked?"),
                                                                  onSubmit: () {
                                                                    scheduleBloc.add(
                                                                        ClearMealPrep(
                                                                            id: widget.id));
                                                                  },
                                                                ));
                                                      }
                                                    : () {
                                                        scheduleBloc.add(
                                                            CookedMeal(
                                                                id: widget.id));
                                                      },
                                                icon: Icon(
                                                  Icons.check_circle,
                                                  color: isCooked
                                                      ? TheColors.lightGreen
                                                      : TheColors.faintGrey,
                                                  size: 48.sp,
                                                ),
                                              ),
                                              Text(
                                                "Cooked",
                                                style: TextStyle(
                                                  color: TheColors.faintGrey,
                                                ),
                                              )
                                            ],
                                          ),
                                          XMargin(10.w),
                                          if (!isCooked)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                onPressed: isOrdered
                                                    ? () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                MyAlertDialog(
                                                                  title:
                                                                      "Change?",
                                                                  buttonText:
                                                                      "Yes",
                                                                  content:
                                                                      const Text(
                                                                          "Are you sure you want to cancel Ordered?"),
                                                                  onSubmit: () {
                                                                    scheduleBloc.add(
                                                                        ClearMealPrep(
                                                                            id: widget.id));
                                                                  },
                                                                ));
                                                      }
                                                    : () {
                                                        setState(() {
                                                          isOrdered = true;
                                                          isCooked = false;
                                                        });
                                                        scheduleBloc
                                                            .add(OrderedMeal(
                                                          id: widget.id,
                                                        ));
                                                      },
                                                icon: Icon(
                                                  Icons.shopping_bag,
                                                  color: isOrdered
                                                      ? TheColors.lightGreen
                                                      : TheColors.faintGrey,
                                                  size: 48.sp,
                                                ),
                                              ),
                                              Text(
                                                "Ordered",
                                                style: TextStyle(
                                                  color: TheColors.faintGrey,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          widget.mealPrep?.displayName ?? "",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 48.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        )
                      : Image.file(
                          File(widget.mealImage),
                          height: 200.h,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                          color: TheColors.black.withOpacity(0.15),
                          colorBlendMode: BlendMode.darken,
                        )
                  : isPassed
                      ? Stack(
                          children: [
                            Container(
                              height: 200.h,
                              color: TheColors.pasteGreen.withOpacity(0.5),
                            ),
                            Positioned(
                              bottom: 4.h,
                              right: 4.h,
                              child: Text(
                                'PASSED',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          height: 200.h,
                          color: TheColors.pasteGreen,
                        ),
              Positioned(
                top: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.ios_share,
                        size: 24,
                        color: TheColors.white,
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border,
                        size: 24,
                        color: TheColors.white,
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.mealTime,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: TheColors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.25),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${widget.mealServings} servings of",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: TheColors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 4),
                                blurRadius: 4.r,
                                color: TheColors.black.withOpacity(0.25),
                              )
                            ]),
                      ),
                      SizedBox(
                        width: 215.w,
                        child: Text(
                          widget.mealName,
                          style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w900,
                            color: TheColors.white,
                            shadows: [
                              Shadow(
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.25),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/pantry/custom_widgets/alert_dialog.dart';

class PlannedMealDisplay extends StatelessWidget {
  final String mealTime;
  final String mealName;
  final String mealImage;
  final String mealServings;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onShare;
  final VoidCallback onFavorite;

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
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => onEdit(),
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
                        onSubmit: onDelete,
                      );
                    });
              },
              icon: Icons.delete_outline_rounded,
            ),
          ]),
      child: Stack(
        children: [
          mealImage.isNotEmpty
              ? Image.file(
                  File(mealImage),
                  height: 200.h,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                  color: TheColors.black.withOpacity(0.15),
                  colorBlendMode: BlendMode.darken,
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
                    mealTime,
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
                    "${mealServings} servings of",
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
                      mealName,
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
  }
}

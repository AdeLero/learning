import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_learning/customizations/colors.dart';

class PlannedMealDisplay extends StatelessWidget {
  const PlannedMealDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane:
          ActionPane(extentRatio: 0.25, motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) {},
          backgroundColor: TheColors.deepGreen,
          foregroundColor: TheColors.lightGreen,
          icon: Icons.edit_outlined,
        ),
      ]),
      endActionPane:
          ActionPane(extentRatio: 0.25, motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            // TODO Implement dialog for delete
          },
          backgroundColor: TheColors.deepRed,
          foregroundColor: TheColors.errorRed,
          icon: Icons.delete_outline_rounded,
        ),
      ]),
      child: Stack(
        children: [
          Container(
            height: 200.h,
            color: TheColors.tealGreen,
          ),
          // TODO Add Image on to the stack
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
                    "Breakfast",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
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
                  SizedBox(
                    width: 215,
                    child: Text(
                      "Rice",
                      style: TextStyle(
                        fontSize: 40,
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

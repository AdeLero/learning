import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/pantry/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/models/meal/meal_model.dart';

class MealDetail extends StatelessWidget {
  final Meal meal;
  const MealDetail({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final currentState = authBloc.state;

    String userName = "Username";
    if (currentState is Authenticated) {
      userName = currentState.user.displayName ?? "Username";
    }
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 500.h,
          pinned: true,
          backgroundColor: pantryTheme.primaryColor,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              meal.image!,
              fit: BoxFit.cover,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              size: 24,
              color: TheColors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.ios_share,
                color: TheColors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border_outlined,
                color: TheColors.white,
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          meal.name,
                          style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w900,
                            color: pantryTheme.primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: TheColors.faintGrey,
                            ),
                            Text(
                              "${meal.timeToCook} Mins",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontStyle: FontStyle.italic,
                                color: TheColors.faintGrey,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Text(
                      "By $userName",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontStyle: FontStyle.italic,
                        color: TheColors.faintGrey,
                      ),
                    ),
                  ],
                ),
                YMargin(8.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What You Need",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: meal.mealIngredients.length,
                      itemBuilder: (context, index) {
                        final mealIngredient = meal.mealIngredients[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              mealIngredient.ingredient.name,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "${mealIngredient.quantity} ${mealIngredient.ingredient.unitOfMeasurement}",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                YMargin(8.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How to cook",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      meal.howToCook ?? "",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

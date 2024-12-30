import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/screens/ingredient/add_ingredient.dart';
import 'package:my_learning/pantry/screens/ingredient/inventory_screen.dart';
import 'package:my_learning/pantry/screens/meal/meal_inventory_screen.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: TabBar(
                    labelColor: pantryTheme.primaryColor,
                    labelStyle: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w900,
                    ),
                    unselectedLabelColor: TheColors.grey,
                    indicatorColor: pantryTheme.primaryColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const  [
                      Tab(text: 'Inventory',),
                      Tab(text: 'Meals',),
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.75,
                  child: const TabBarView(
                    children: [
                      InventoryScreen(),
                      MealInventoryScreen(),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}

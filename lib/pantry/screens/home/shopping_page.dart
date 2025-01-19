import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/screens/shopping_list/shopping_list_page.dart';
import 'package:my_learning/pantry/screens/shopping_list/shopping_online_page.dart';

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20.w, top: 30.h),
              width: double.maxFinite,
              color: pantryTheme.primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shopping",
                    style: TextStyle(
                      color: TheColors.white,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  YMargin(60.h),
                ],
              ),
            ),
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    color: pantryTheme.primaryColor,
                    child: TabBar(
                        labelColor: TheColors.white,
                        labelStyle: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w900,
                        ),
                        unselectedLabelColor: TheColors.grey,
                        indicatorColor: TheColors.white,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: const [
                          Tab(text: "List"),
                          Tab(text: "Online"),
                        ]),
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.4,
                    child: const TabBarView(children: [
                      ShoppingListPage(),
                      ShoppingOnlinePage(),
                    ]),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

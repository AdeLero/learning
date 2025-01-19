import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/customizations/custom_widgets/pantry_button.dart';
import 'package:my_learning/pantry/screens/shopping_list/generate_shopping_list_sheet.dart';

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: PantryButton(
              onPressed: () {
                showModalBottomSheet(context: context, builder: (context) {
                  return const GenerateShoppingListSheet();
                });
              },
              borderRadius: 8.r,
              buttonColor: TheColors.pasteGreen,
              label: "Generate Shopping List",
              labelColor: TheColors.deepGreen,
            ),
          ),
          Container(
            width: double.maxFinite,
            color: TheColors.deepGreen,
            child: Text(
              "Saved Shopping Lists",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: TheColors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}

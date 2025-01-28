import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/pantry/models/shopping_trips/shopping_trip_model.dart';
import 'package:my_learning/pantry/routes/routes.dart';

class ConfirmationScreen extends StatelessWidget {
  final ShoppingTrip shoppingList;

  const ConfirmationScreen({required this.shoppingList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shopping List Ready")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your shopping list has been generated!",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            YMargin(20.h),
            ElevatedButton(
              onPressed: () {
                // Navigate to the screen displaying the full shopping list
                Navigator.pushNamed(
                  context,
                  Routes.shoppingListsPage,
                  arguments: shoppingList,
                );
              },
              child: Text("View Shopping List"),
            ),
          ],
        ),
      ),
    );
  }
}

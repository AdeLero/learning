import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_learning/customizations/custom_widgets/my_bottom_nav_bar.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/routes/routes.dart';
import 'package:my_learning/pantry/screens/ingredient/add_ingredient.dart';
import 'package:my_learning/pantry/screens/home/account_page.dart';
import 'package:my_learning/pantry/screens/home/home_page.dart';
import 'package:my_learning/pantry/screens/home/lists_page.dart';
import 'package:my_learning/pantry/screens/home/order_page.dart';
import 'package:my_learning/pantry/screens/home/shopping_page.dart';
import 'package:my_learning/pantry/screens/meal/create_meal.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentPageIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        const ListsPage(),
        const ShoppingPage(),
        const HomePage(),
        const OrderPage(),
        const AccountPage()
      ][_currentPageIndex],
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        children: [
          SpeedDialChild(
            label: 'Ingredient',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddIngredient(),
                ),
              );
            },
          ),
          SpeedDialChild(
            label: 'Meal',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateMeal(),
                ),
              );
            },
          ),
          SpeedDialChild(
            label: 'Schedule Meals',
            onTap: () {
              Navigator.pushNamed(context, Routes.scheduleMeal);
            },
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _currentPageIndex,
        backgroundColor: pantryTheme.scaffoldBackgroundColor,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          MyNavItem(icon: Icons.list, label: "List"),
          MyNavItem(icon: Icons.shopping_cart_outlined, label: "Shop"),
          MyNavItem(icon: Icons.home, label: "Home"),
          MyNavItem(icon: FontAwesomeIcons.burger, label: "Order"),
          MyNavItem(icon: CupertinoIcons.person, label: "Account"),
        ],
      ),
    );
  }
}

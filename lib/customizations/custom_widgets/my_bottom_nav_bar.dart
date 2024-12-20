import 'package:flutter/material.dart';
import 'package:my_learning/customizations/colors.dart';

class MyNavItem {
  final IconData icon;
  final String label;

  MyNavItem({
    required this.icon,
    required this.label,
  });
}

class MyBottomNavBar extends StatelessWidget {
  final List<MyNavItem> items;
  final int? currentIndex;
  final Function(int)? onTap;
  final bool showUnselectedLabels;
  final bool showSelectedLabels;
  final Color? backgroundColor;
  const MyBottomNavBar({
    super.key,
    required this.items,
    this.currentIndex,
    this.onTap,
    this.showSelectedLabels = false,
    this.showUnselectedLabels = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: backgroundColor,
      showSelectedLabels: showSelectedLabels,
      showUnselectedLabels: showUnselectedLabels,
      currentIndex: currentIndex ?? 0,
      onTap: onTap,
      items: items.asMap().entries.map((entry) {
        int index = entry.key;
        MyNavItem item = entry.value;

        bool isSelected = index == currentIndex;

        return BottomNavigationBarItem(
          icon: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isSelected ? LinearGradient(
                  colors: [
                    TheColors.tealGreen,
                    TheColors.deepGreen,
                  ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ) : null,
              color: isSelected ? null : Colors.transparent,
            ),
            child: Icon(
              item.icon,
              color: isSelected ?  TheColors.white : TheColors.black,
            ),
          ),
          label: item.label,
        );
      }).toList(),
    );
  }
}

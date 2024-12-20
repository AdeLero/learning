import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/pantry/bloc/inventory_bloc.dart';
import 'package:my_learning/pantry/custom_widgets/empty_display.dart';
import 'package:my_learning/pantry/custom_widgets/inventory_display_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, state) {
            if (state is InventoryLoaded && state.inventory.isNotEmpty) {
              final inventory = state.inventory;
              return InventoryDisplayWidget(
                inventory: inventory,
              );
            } else if (state is InventoryInitial) {
              return EmptyDisplay(
                  imagePath: "lib/assets/images/no_scheduled_meals.png",
                  text: "You Have not Planned Any Meals");
            }
            return Container();
          },
        ),
      ),
    );
  }
}

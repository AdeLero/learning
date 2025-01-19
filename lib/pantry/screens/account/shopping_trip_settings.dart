import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/customizations/custom_widgets/pantry_button.dart';
import 'package:my_learning/pantry/blocs/trip_bloc/trip_bloc.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/models/shopping_trips/shopping_frequency_model.dart';

class ShoppingTripSettings extends StatefulWidget {
  const ShoppingTripSettings({super.key});

  @override
  State<ShoppingTripSettings> createState() => _ShoppingTripSettingsState();
}

class _ShoppingTripSettingsState extends State<ShoppingTripSettings> {

  @override
  Widget build(BuildContext context) {
    final tripBloc = context.read<TripBloc>();

    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        ShoppingFrequency? frequency;
        if (state is TempIntervalSelected) {
          frequency = state.frequency;
        } else if (state is TripIntervalUpdated) {
          frequency = state.frequency;
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 24.sp,
                color: pantryTheme.primaryColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "How often would you like to restock your",
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Image.asset(
                  "lib/assets/images/Pantry_App_Logo.png",
                  width: 250.w,
                ),
                YMargin(60.h),
                DropdownButtonFormField<ShoppingFrequency>(
                  value:frequency ?? ShoppingFrequency.weekly,
                  onChanged: (ShoppingFrequency? newValue) {
                    tripBloc.add(TempFrequencySelected(frequency: newValue!));
                  },
                  items: ShoppingFrequency.values.map((
                      ShoppingFrequency value) {
                    return DropdownMenuItem<ShoppingFrequency>(
                      value: value,
                      child: Text(value.displayName),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Select Frequency', // Add a hint text
                  ),
                ),
                YMargin(60.h),
                Row(
                  children: [
                    Expanded(
                        child: PantryButton(
                          onPressed: () {
                            tripBloc.add(ChangeTripFrequency(frequency: frequency!));
                            Navigator.pop(context);
                          },
                          label: "Set Shopping Trips",
                          labelColor: TheColors.white,
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

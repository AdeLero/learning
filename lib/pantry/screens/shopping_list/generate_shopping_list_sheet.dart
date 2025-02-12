import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/customizations/custom_widgets/pantry_button.dart';
import 'package:my_learning/pantry/blocs/bloc_streams/bloc_event_stream.dart';
import 'package:my_learning/pantry/blocs/trip_bloc/trip_bloc.dart';
import 'package:my_learning/pantry/custom_widgets/alert_dialog.dart';
import 'package:my_learning/pantry/custom_widgets/calendar.dart';
import 'package:my_learning/pantry/custom_widgets/custom_switch.dart';
import 'package:my_learning/pantry/routes/routes.dart';

class GenerateShoppingListSheet extends StatelessWidget {
  const GenerateShoppingListSheet({super.key});

  @override
  Widget build(BuildContext icontext) {
    final tripBloc = icontext.read<TripBloc>();

    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        DateTime date = (state is TripListDetailing) ? state.tripDate : DateTime.now();
        return Scaffold(
          backgroundColor: TheColors.faintGrey,
          body: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Generate Shopping List",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900,
                    color: TheColors.deepGreen,
                  ),
                ),
                YMargin(70.h),
                Text(
                  "Set Shopping Date",
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                ),
                YMargin(25.h),
                Row(children: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: icontext,
                          builder: (context) {
                            return Calendar(onDaySelected: (dateSelected) {
                              tripBloc.add(GetTripDate(tripDate: dateSelected));
                            });
                          });
                    },
                    icon: const Icon(Icons.calendar_today_outlined),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy (E)').format(date),
                  ),
                ]),
                YMargin(60.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Include Ingredients below Critical Quantity?",
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    CustomSwitch(
                      value: true,
                      onChanged: (v) {},
                    ),
                  ],
                ),
                YMargin(24.h),
                PantryButton(
                  onPressed: () async {
                    print("I tapped the button");

                    tripBloc.add(GenerateShoppingList(date: date));


                    Navigator.pushNamed(context, Routes.loadingScreen);

                  },
                  label: "Generate Shopping List",
                  labelColor: TheColors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

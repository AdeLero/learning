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
import 'package:my_learning/pantry/models/shopping_trips/shopping_trip_model.dart';
import 'package:my_learning/pantry/routes/routes.dart';
import 'package:my_learning/pantry/screens/shopping_list/generate_shopping_list_sheet.dart';

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext icontext) {
    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        List<ShoppingTrip> trips = (state is TripListSaved) ? state.savedLists : <ShoppingTrip>[];
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.w),
                child: PantryButton(
                  onPressed: () {

                    showModalBottomSheet<DateTime>(
                        context: icontext, builder: (context) {
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
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  final trip = trips[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: TheColors.faintGrey,
                          )
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('dd/MM/yy').format(trip.date),
                            style: TextStyle(
                              fontSize: 24.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}

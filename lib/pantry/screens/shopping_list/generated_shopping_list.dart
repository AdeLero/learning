import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/pantry/blocs/trip_bloc/trip_bloc.dart';
import 'package:my_learning/pantry/models/shopping_trips/shopping_trip_model.dart';

class GeneratedShoppingList extends StatelessWidget {
  final ShoppingTrip shoppingTrip;
  const GeneratedShoppingList({super.key, required this.shoppingTrip});

  @override
  Widget build(BuildContext context) {
    final tripBloc = context.read<TripBloc>();
    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        ShoppingTrip thisTrip = (state is TripListGenerated) ? state.shoppingList : ShoppingTrip(shoppingList: [], date: DateTime.now());
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 24.sp,
                color: TheColors.deepGreen,
              ),
            ),
            title: Text(
              DateFormat('dd/MM/yyyy').format(thisTrip.date),
              style: TextStyle(
                color: TheColors.deepGreen,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  size: 24.sp,
                ),
              ),
              IconButton(
                onPressed: () {
                  tripBloc.add(SaveShoppingList(shoppingTrip: thisTrip));
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.save,
                  size: 24.sp,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  height: 40.h,
                  color: TheColors.deepGreen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ingredients",
                        style: TextStyle(
                          color: TheColors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Qty",
                        style: TextStyle(
                          color: TheColors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: thisTrip.shoppingList.length,
                  itemBuilder: (context, index) {
                    final tripList = thisTrip.shoppingList[index];
                    final tripIngredient = tripList.name;
                    final quantity = tripList.quantity;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Container(
                        padding: EdgeInsets.only(top: 8.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: TheColors.faintGrey,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tripIngredient,
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              quantity.toString(),
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

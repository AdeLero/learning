import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/custom_textbox.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:my_learning/customizations/custom_widgets/pantry_button.dart';
import 'package:my_learning/pantry/bloc/inventory_bloc.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';

class AddIngredient extends StatelessWidget {
  const AddIngredient({super.key});

  @override
  Widget build(BuildContext context) {
    final inventoryBloc = BlocProvider.of<InventoryBloc>(context);
    TextEditingController _ingredientName = TextEditingController();
    TextEditingController _quantity = TextEditingController();
    TextEditingController _criticalQty = TextEditingController();
    TextEditingController _uOM = TextEditingController();
    return BlocProvider(
      create: (context) => InventoryBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: pantryTheme.primaryColor,
            ),
            iconSize: 24,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create An",
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: TheColors.black,
                  ),
                ),
                Text(
                  "Ingredient",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 50.sp,
                    color: TheColors.black,
                  ),
                ),
                YMargin(30.h),
                CustomTextbox(
                  label: "Ingredient Name",
                  controller: _ingredientName,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Input",
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.cancel_outlined),
                  ),
                  borderRadius: 4,
                ),
                YMargin(30.h),
                Row(
                  children: [
                    SizedBox(
                      width: 120.w,
                      child: CustomTextbox(
                        label: "Quantity",
                        controller: _quantity,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Input",
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.cancel_outlined),
                        ),
                        borderRadius: 4,
                      ),
                    ),
                    XMargin(60.w),
                    SizedBox(
                      width: 120.w,
                      child: CustomTextbox(
                        label: "Critical Qty",
                        controller: _criticalQty,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Input",
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.cancel_outlined),
                        ),
                        borderRadius: 4,
                      ),
                    ),
                  ],
                ),
                YMargin(30.h),
                CustomTextbox(
                  label: "Unit of Measurement",
                  controller: _uOM,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Input",
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.cancel_outlined),
                  ),
                  borderRadius: 4,
                ),
                YMargin(100.h),
                PantryButton(
                  onPressed: () {
                    inventoryBloc.add(
                      AddIngredientToInventory(
                        name: _ingredientName.text,
                        unitOfMeasurement: _uOM.text,
                        quantity: _quantity.text,
                        criticalQty: _criticalQty.text,
                      ),
                    );
                    _ingredientName.clear();
                    _quantity.clear();
                    _criticalQty.clear();
                    _uOM.clear();

                    Navigator.pop(context);
                  },
                  label: "Create Ingredient",
                ),
                BlocBuilder<InventoryBloc, InventoryState>(
                  bloc: inventoryBloc,
                  builder: (context, state) {
                    String message = "";
                    if (state is InventoryError) {
                      message = state.message;
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error,
                          color: pantryTheme.indicatorColor,
                        ),
                        Text(message),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

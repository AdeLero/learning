// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealIngredient _$MealIngredientFromJson(Map<String, dynamic> json) =>
    MealIngredient(
      ingredient:
          Ingredient.fromJson(json['ingredient'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num).toDouble(),
    );

Map<String, dynamic> _$MealIngredientToJson(MealIngredient instance) =>
    <String, dynamic>{
      'ingredient': instance.ingredient,
      'quantity': instance.quantity,
    };

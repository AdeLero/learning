// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
      id: json['id'] as String?,
      name: json['name'] as String,
      mealIngredients: (json['mealIngredients'] as List<dynamic>)
          .map((e) => MealIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'] as String?,
      howToCook: json['howToCook'] as String?,
      timeToCook: json['timeToCook'] as String?,
    );

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mealIngredients': instance.mealIngredients,
      'image': instance.image,
      'howToCook': instance.howToCook,
      'timeToCook': instance.timeToCook,
    };

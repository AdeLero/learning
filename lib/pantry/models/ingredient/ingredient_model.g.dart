// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      id: json['id'] as String?,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unitOfMeasurement: json['unitOfMeasurement'] as String,
      criticalQty: (json['criticalQty'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'unitOfMeasurement': instance.unitOfMeasurement,
      'criticalQty': instance.criticalQty,
    };

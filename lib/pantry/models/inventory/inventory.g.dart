// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inventory _$InventoryFromJson(Map<String, dynamic> json) => Inventory(
      ingredientName: json['ingredientName'] as String,
      quantity: (json['quantity'] as num).toDouble(),
    );

Map<String, dynamic> _$InventoryToJson(Inventory instance) => <String, dynamic>{
      'ingredientName': instance.ingredientName,
      'quantity': instance.quantity,
    };

import 'package:json_annotation/json_annotation.dart';

part 'inventory.g.dart';

@JsonSerializable()
class Inventory {
  final String ingredientName;
  final double quantity;

  Inventory({
    required this.ingredientName,
    required this.quantity,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) => _$InventoryFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryToJson(this);
}

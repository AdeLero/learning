import 'package:json_annotation/json_annotation.dart';

part 'ingredient_model.g.dart';

@JsonSerializable()
class Ingredient {
  final String? id;
  final String name;
  final double quantity;
  final String unitOfMeasurement;
  final double? criticalQty;

  Ingredient(
      {this.id,
      required this.name,
      required this.quantity,
      required this.unitOfMeasurement,
      this.criticalQty});

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

import 'package:my_learning/pantry/models/ingredient/ingredient_model.dart';

class ShoppingTrip {
  final List<Ingredient> shoppingList;
  final DateTime date;

  ShoppingTrip({
    required this.shoppingList,
    required this.date,
  });

  ShoppingTrip copyWith({
    List<Ingredient>? shoppingList,
    DateTime? date,

}) {
    return ShoppingTrip(
        shoppingList: shoppingList ?? this.shoppingList,
        date: date ?? this.date
    );
  }

  factory ShoppingTrip.fromJson(Map<String, dynamic> json) {
    return ShoppingTrip(
      shoppingList: (json['shoppingList'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shoppingList': shoppingList,
      'date': date.toIso8601String(),
    };
  }
}

class TripIngredient {
  final String name;
  final double quantity;

  TripIngredient({
    required this.name,
    required this.quantity,
  });

  TripIngredient copyWith({
    String? name,
    double? quantity,
  }) {
    return TripIngredient(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
    );
  }

  factory TripIngredient.fromJson(Map<String, dynamic> json) {
    return TripIngredient(
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }
}

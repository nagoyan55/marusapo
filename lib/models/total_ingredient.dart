class TotalIngredient {
  final String name;
  num quantity;
  final String unit;

  TotalIngredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  factory TotalIngredient.fromJson(Map<String, dynamic> json) {
    return TotalIngredient(
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      unit: json['unit'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }

  void addQuantity(num additionalQuantity) {
    quantity += additionalQuantity;
  }

  @override
  String toString() {
    return 'TotalIngredient{name: $name, quantity: $quantity, unit: $unit}';
  }
}

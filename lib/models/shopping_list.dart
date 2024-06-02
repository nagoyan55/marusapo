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

class CheckedIngredient {
  final String name;
  bool isChecked;

  CheckedIngredient({
    required this.name,
    this.isChecked = false,
  });

  factory CheckedIngredient.fromJson(Map<String, dynamic> json) {
    return CheckedIngredient(
      name: json['name'],
      isChecked: json['isChecked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isChecked': isChecked,
    };
  }
}

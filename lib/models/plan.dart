class WeekPlan {
  final List<DayPlan> days;

  WeekPlan({required this.days});

  factory WeekPlan.fromJson(Map<String, dynamic> json) {
    if (json.length != 1 || !json.containsKey('days')) {
      throw FormatException('Invalid JSON format');
    }

    return WeekPlan(
      days: List<DayPlan>.from(json['days'].map((x) => DayPlan.fromJson(x))),
    );
  }
}

class DayPlan {
  final Menu breakfast;
  final Menu lunch;
  final Menu dinner;
  final DateTime date;
  final String weekday;

  DayPlan({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.date,
    required this.weekday,
  });

  factory DayPlan.fromJson(Map<String, dynamic> json) {
    if (json.length != 3 || !json.containsKey('breakfast') || !json.containsKey('lunch') || !json.containsKey('dinner')) {
      throw FormatException('Invalid JSON format');
    }

    return DayPlan(
      breakfast: Menu.fromJson(json['breakfast']),
      lunch: Menu.fromJson(json['lunch']),
      dinner: Menu.fromJson(json['dinner']),
      date: DateTime.now(), // 仮の日付
      weekday: '', // 仮の曜日
    );
  }
}

class Menu {
  final String name;
  final List<Ingredient> ingredients;

  Menu({
    required this.name,
    required this.ingredients,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    if (json.length != 2 || !json.containsKey('name') || !json.containsKey('ingredients')) {
      throw FormatException('Invalid JSON format');
    }

    return Menu(
      name: json['name'],
      ingredients: List<Ingredient>.from(json['ingredients'].map((x) => Ingredient.fromJson(x))),
    );
  }
}

class Ingredient {
  final String name;
  final num quantity;
  final String unit;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    if (json.length != 3 || !json.containsKey('name') || !json.containsKey('quantity') || !json.containsKey('unit')) {
      throw FormatException('Invalid JSON format');
    }

    return Ingredient(
      name: json['name'],
      quantity: json['quantity'],
      unit: json['unit'],
    );
  }
}

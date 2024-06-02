// モデル定義ファイル (models/model.dart)
import 'dart:convert';

class Ingredient {
  final String name;
  final num quantity;
  final String unit;

  Ingredient({required this.name, required this.quantity, required this.unit});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      quantity: json['quantity'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}

class Menu {
  final String name;
  final List<Ingredient> ingredients;

  Menu({required this.name, required this.ingredients});

  factory Menu.fromJson(Map<String, dynamic> json) {
    var ingredientsFromJson = json['ingredients'] as List;
    List<Ingredient> ingredientsList =
        ingredientsFromJson.map((i) => Ingredient.fromJson(i)).toList();

    return Menu(
      name: json['name'],
      ingredients: ingredientsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ingredients': ingredients.map((i) => i.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return jsonEncode(this.toJson());
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
    return DayPlan(
      breakfast: Menu.fromJson(json['breakfast']),
      lunch: Menu.fromJson(json['lunch']),
      dinner: Menu.fromJson(json['dinner']),
      date: DateTime.parse(json['date']),
      weekday: json['weekday'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'breakfast': breakfast.toJson(),
      'lunch': lunch.toJson(),
      'dinner': dinner.toJson(),
      'date': date.toIso8601String(),
      'weekday': weekday,
    };
  }

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}

class WeekPlan {
  final List<DayPlan> days;

  WeekPlan({required this.days});

  factory WeekPlan.fromJson(Map<String, dynamic> json) {
    var daysFromJson = json['days'] as List;
    List<DayPlan> daysList =
        daysFromJson.map((d) => DayPlan.fromJson(d)).toList();

    return WeekPlan(
      days: daysList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'days': days.map((d) => d.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}

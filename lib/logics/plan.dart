import 'dart:convert';
import 'package:myapp/models/model.dart';
import 'package:myapp/models/total_ingredient.dart';
import 'package:flutter/services.dart' show rootBundle;

WeekPlan createPlanFromJson(String jsonString, DateTime startDate) {
  try {
    final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
    WeekPlan weekPlan = WeekPlan.fromJson(jsonResponse);
    setDates(weekPlan, startDate);
    return weekPlan;
  } catch (e) {
    throw FormatException("Invalid JSON format: $e");
  }
}

void setDates(WeekPlan weekPlan, DateTime startDate) {
  for (int i = 0; i < weekPlan.days.length; i++) {
    weekPlan.days[i] = DayPlan(
      breakfast: weekPlan.days[i].breakfast,
      lunch: weekPlan.days[i].lunch,
      dinner: weekPlan.days[i].dinner,
      date: startDate.add(Duration(days: i)),
      weekday: _getWeekdayName(startDate.add(Duration(days: i))),
    );
  }
}

String _getWeekdayName(DateTime date) {
  switch (date.weekday) {
    case DateTime.monday:
      return '月';
    case DateTime.tuesday:
      return '火';
    case DateTime.wednesday:
      return '水';
    case DateTime.thursday:
      return '木';
    case DateTime.friday:
      return '金';
    case DateTime.saturday:
      return '土';
    case DateTime.sunday:
      return '日';
    default:
      return '';
  }
}

List<TotalIngredient> calculateTotalIngredients(WeekPlan weekPlan) {
  final Map<String, TotalIngredient> totalIngredients = {};

  for (final dayPlan in weekPlan.days) {
    for (final menu in [dayPlan.breakfast, dayPlan.lunch, dayPlan.dinner]) {
      for (final ingredient in menu.ingredients) {
        if (totalIngredients.containsKey(ingredient.name)) {
          totalIngredients[ingredient.name]!.addQuantity(ingredient.quantity);
        } else {
          totalIngredients[ingredient.name] = TotalIngredient(
            name: ingredient.name,
            quantity: ingredient.quantity,
            unit: ingredient.unit,
          );
        }
      }
    }
  }

  return totalIngredients.values.toList();
}

Future<String> loadJson(String path) async {
  return await rootBundle.loadString(path);
}

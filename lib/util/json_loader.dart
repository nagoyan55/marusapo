import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myapp/models/week_plan.dart';

Future<WeekPlan> loadWeekPlan() async {
  final jsonString = await rootBundle.loadString('assets/plan.json');
  final jsonResponse = jsonDecode(jsonString);
  return WeekPlan.fromJson(jsonResponse);
}

Future<String> loadJson(String path) async {
  return await rootBundle.loadString(path);
}

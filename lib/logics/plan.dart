import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:myapp/models/model.dart'; // モデルファイルをインポート

Future<String> loadJson(String path) async {
  return await rootBundle.loadString(path);
}

Future<WeekPlan> createPlanFromJson(String jsonString, DateTime startDate) async {
  Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
  WeekPlan weekPlan = WeekPlan.fromJson(jsonResponse);
  setDates(weekPlan, startDate);
  return weekPlan;
}

void setDates(WeekPlan weekPlan, DateTime startDate) {
  // 指定された日付を基準に一週間分の日付を設定
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

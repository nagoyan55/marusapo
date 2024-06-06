import 'package:myapp/models/week_plan.dart';
import 'package:myapp/models/day_plan.dart';

WeekPlan setDates(WeekPlan weekPlan, DateTime startDate) {
  final List<DayPlan> updatedDays = weekPlan.days.asMap().map((i, dayPlan) {
    return MapEntry(
      i,
      dayPlan.copyWith(
        date: startDate.add(Duration(days: i)),
        weekday: _getWeekdayName(startDate.add(Duration(days: i))),
      ),
    );
  }).values.toList();

  return weekPlan.copyWith(days: updatedDays);
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

import 'package:freezed_annotation/freezed_annotation.dart';
import 'day_plan.dart';

part 'week_plan.freezed.dart';
part 'week_plan.g.dart';

@freezed
class WeekPlan with _$WeekPlan {
  const factory WeekPlan({
    required List<DayPlan> days,
  }) = _WeekPlan;

  factory WeekPlan.fromJson(Map<String, dynamic> json) => _$WeekPlanFromJson(json);
}

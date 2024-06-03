import 'package:freezed_annotation/freezed_annotation.dart';
import 'menu.dart';

part 'day_plan.freezed.dart';
part 'day_plan.g.dart';

@freezed
class DayPlan with _$DayPlan {
  const factory DayPlan({
    required DateTime? date,
    required String? weekday,
    required Menu menu,
  }) = _DayPlan;

  factory DayPlan.fromJson(Map<String, dynamic> json) => _$DayPlanFromJson(json);
}

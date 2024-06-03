// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeekPlanImpl _$$WeekPlanImplFromJson(Map<String, dynamic> json) =>
    _$WeekPlanImpl(
      days: (json['days'] as List<dynamic>)
          .map((e) => DayPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$WeekPlanImplToJson(_$WeekPlanImpl instance) =>
    <String, dynamic>{
      'days': instance.days,
    };

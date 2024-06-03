// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DayPlanImpl _$$DayPlanImplFromJson(Map<String, dynamic> json) =>
    _$DayPlanImpl(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      weekday: json['weekday'] as String?,
      menu: Menu.fromJson(json['menu'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DayPlanImplToJson(_$DayPlanImpl instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'weekday': instance.weekday,
      'menu': instance.menu,
    };

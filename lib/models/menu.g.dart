// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MenuImpl _$$MenuImplFromJson(Map<String, dynamic> json) => _$MenuImpl(
      breakfast: Meal.fromJson(json['breakfast'] as Map<String, dynamic>),
      lunch: Meal.fromJson(json['lunch'] as Map<String, dynamic>),
      dinner: Meal.fromJson(json['dinner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MenuImplToJson(_$MenuImpl instance) =>
    <String, dynamic>{
      'breakfast': instance.breakfast,
      'lunch': instance.lunch,
      'dinner': instance.dinner,
    };

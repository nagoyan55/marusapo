// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IngredientImpl _$$IngredientImplFromJson(Map<String, dynamic> json) =>
    _$IngredientImpl(
      name: json['name'] as String,
      quantity: json['quantity'] as num,
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$$IngredientImplToJson(_$IngredientImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': instance.unit,
    };

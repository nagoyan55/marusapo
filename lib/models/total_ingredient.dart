import 'package:freezed_annotation/freezed_annotation.dart';

part 'total_ingredient.freezed.dart';
part 'total_ingredient.g.dart';

@freezed
class TotalIngredient with _$TotalIngredient {
  const factory TotalIngredient({
    required String name,
    required num quantity,
    required String unit,
  }) = _TotalIngredient;

  factory TotalIngredient.fromJson(Map<String, dynamic> json) =>
      _$TotalIngredientFromJson(json);
}

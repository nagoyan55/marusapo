import 'package:freezed_annotation/freezed_annotation.dart';

part 'checked_ingredient.freezed.dart';
part 'checked_ingredient.g.dart';

@freezed
class CheckedIngredient with _$CheckedIngredient {
  const factory CheckedIngredient({
    required String name,
    required bool isChecked,
  }) = _CheckedIngredient;

  factory CheckedIngredient.fromJson(Map<String, dynamic> json) =>
      _$CheckedIngredientFromJson(json);
}

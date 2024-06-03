import 'package:freezed_annotation/freezed_annotation.dart';
import 'ingredient.dart';
import 'recipe.dart';

part 'meal.freezed.dart';
part 'meal.g.dart';

@freezed
class Meal with _$Meal {
  const factory Meal({
    required String name,
    required List<Ingredient> ingredients,
    required Recipe recipe,
  }) = _Meal;

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
}

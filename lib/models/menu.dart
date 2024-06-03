import 'package:freezed_annotation/freezed_annotation.dart';
import 'meal.dart';

part 'menu.freezed.dart';
part 'menu.g.dart';

@freezed
class Menu with _$Menu {
  const factory Menu({
    required Meal breakfast,
    required Meal lunch,
    required Meal dinner,
  }) = _Menu;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
}

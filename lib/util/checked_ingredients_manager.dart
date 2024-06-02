import 'package:myapp/models/ingredients.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CheckedIngredientsManager {
  static const String key = 'checkedIngredients';

  static Future<void> saveCheckedIngredients(
      List<CheckedIngredient> ingredients) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList = ingredients
        .map((ingredient) => jsonEncode(ingredient.toJson()))
        .toList();
    await prefs.setStringList(key, jsonList);
  }

  static Future<List<CheckedIngredient>> loadCheckedIngredients() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(key);
    if (jsonList == null) {
      return [];
    }
    return jsonList
        .map((jsonString) => CheckedIngredient.fromJson(jsonDecode(jsonString)))
        .toList();
  }
}

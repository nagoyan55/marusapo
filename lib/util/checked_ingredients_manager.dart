import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:myapp/models/checked_ingredient.dart';

class CheckedIngredientsManager {
  static const _key = 'checkedIngredients';

  static Future<void> saveCheckedIngredients(
      List<CheckedIngredient> ingredients) async {
    final prefs = await SharedPreferences.getInstance();
    final ingredientsJson = jsonEncode(
        ingredients.map((ingredient) => ingredient.toJson()).toList());
    await prefs.setString(_key, ingredientsJson);
  }

  static Future<List<CheckedIngredient>> loadCheckedIngredients() async {
    final prefs = await SharedPreferences.getInstance();
    final ingredientsJson = prefs.getString(_key);
    if (ingredientsJson == null) {
      return [];
    }
    final List<dynamic> decodedJson = jsonDecode(ingredientsJson);
    return decodedJson.map((json) => CheckedIngredient.fromJson(json)).toList();
  }
}

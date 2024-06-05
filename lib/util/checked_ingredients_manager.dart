import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/checked_ingredient.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckedIngredientsManager {
  static Future<String> _getKey() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null && !user.isAnonymous ? user.uid : 'guest';
  }

  static Future<void> saveCheckedIngredients(List<CheckedIngredient> ingredients) async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getKey();
    final ingredientsJson = jsonEncode(ingredients.map((ingredient) => ingredient.toJson()).toList());
    await prefs.setString('checkedIngredients_$key', ingredientsJson);
  }

  static Future<List<CheckedIngredient>> loadCheckedIngredients() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getKey();
    final ingredientsJson = prefs.getString('checkedIngredients_$key');
    if (ingredientsJson == null) {
      return [];
    }
    final List<dynamic> decodedJson = jsonDecode(ingredientsJson);
    return decodedJson.map((json) => CheckedIngredient.fromJson(json)).toList();
  }

  static Future<void> clearCheckedIngredients() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getKey();
    await prefs.remove('checkedIngredients_$key');
  }
}

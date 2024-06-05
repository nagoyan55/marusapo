import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/models/week_plan.dart';
import 'package:myapp/util/checked_ingredients_manager.dart';
import 'dart:convert';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<WeekPlan> fetchPlansFromFirestore() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> planDoc = await _db.collection('plans').doc('examplePlanId').get();
      Map<String, dynamic> data = planDoc.data()!;
      WeekPlan weekPlan = WeekPlan.fromJson(data);
      
      // 保存
      await savePlanToPreferences(weekPlan);
      
      // チェック情報を破棄
      await CheckedIngredientsManager.clearCheckedIngredients();
      
      return weekPlan;
    } catch (e) {
      print('Error fetching plan from Firestore: $e');
      rethrow;
    }
  }

  Future<void> savePlanToPreferences(WeekPlan weekPlan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(weekPlan.toJson());
    await prefs.setString('savedPlan', jsonString);
  }

  Future<WeekPlan?> loadPlanFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('savedPlan');
    if (jsonString != null) {
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      return WeekPlan.fromJson(jsonData);
    }
    return null;
  }

  Future<bool> hasSavedPlan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('savedPlan');
  }

  Future<void> deleteSavedPlan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('savedPlan');
  }
}

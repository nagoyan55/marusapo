import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/models/week_plan.dart';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<String> _getKey() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null && !user.isAnonymous ? user.uid : 'guest';
  }

  Future<int> getPlanCount() async {
    AggregateQuerySnapshot countSnapshot = await _db.collection('plans').count().get();
    return countSnapshot.count!;
  }

  Future<WeekPlan> fetchRandomPlanFromFirestore() async {
    try {
      int planCount = await getPlanCount();
      if (planCount == 0) {
        throw Exception('No plans found in Firestore.');
      }
      int randomIndex = Random().nextInt(planCount);
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db.collection('plans')
          .orderBy(FieldPath.documentId)
          .limit(1)
          .startAt([randomIndex.toString()])
          .get();
      
      if (querySnapshot.docs.isEmpty) {
        throw Exception('Random plan not found.');
      }
      
      DocumentSnapshot<Map<String, dynamic>> randomPlanDoc = querySnapshot.docs.first;
      Map<String, dynamic> data = randomPlanDoc.data()!;
      WeekPlan weekPlan = WeekPlan.fromJson(data);

      // 保存
      await savePlanToPreferences(weekPlan);

      return weekPlan;
    } catch (e) {
      print('Error fetching random plan from Firestore: $e');
      rethrow;
    }
  }

  Future<void> savePlanToPreferences(WeekPlan weekPlan) async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getKey();
    String jsonString = jsonEncode(weekPlan.toJson());
    await prefs.setString('savedPlan_$key', jsonString);
  }

  Future<WeekPlan?> loadPlanFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getKey();
    String? jsonString = prefs.getString('savedPlan_$key');
    if (jsonString != null) {
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      return WeekPlan.fromJson(jsonData);
    }
    return null;
  }

  Future<bool> hasSavedPlan() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getKey();
    return prefs.containsKey('savedPlan_$key');
  }

  Future<void> deleteSavedPlan() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getKey();
    await prefs.remove('savedPlan_$key');
  }
}

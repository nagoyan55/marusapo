import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/week_plan.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<WeekPlan> fetchPlansFromFirestore() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> planDoc = await _db.collection('plans').doc('anotherPlanId').get();
      Map<String, dynamic> data = planDoc.data()!;
      return WeekPlan.fromJson(data);
    } catch (e) {
      print('Error fetching plan from Firestore: $e');
      rethrow;
    }
  }
}

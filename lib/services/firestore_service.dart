import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/week_plan.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<WeekPlan> fetchPlansFromFirestore() async {
    CollectionReference plansCollection = _db.collection('plans');

    // ここでは最初のドキュメントを取得する例を示しています
    DocumentSnapshot planDoc = await plansCollection.doc('examplePlanId').get();
    Map<String, dynamic> data = planDoc.data() as Map<String, dynamic>;

    return WeekPlan.fromJson(data);
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/services/firestore_service.dart';
import 'package:myapp/models/week_plan.dart';
import 'package:myapp/widgets/plan_list.dart';
import 'package:myapp/widgets/shopping_list_screen.dart';

class PlanScreen extends StatefulWidget {
  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<WeekPlan> _weekPlanFuture;

  @override
  void initState() {
    super.initState();
    _loadPlan();
  }

  Future<void> _loadPlan() async {
    WeekPlan? savedPlan = await _firestoreService.loadPlanFromPreferences();
    setState(() {
      if (savedPlan != null) {
        _weekPlanFuture = Future.value(savedPlan);
      } else {
        _weekPlanFuture = _firestoreService.fetchPlansFromFirestore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('こんだてまるさぽくん'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<WeekPlan>(
              future: _weekPlanFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final weekPlan = snapshot.data!;
                  return PlanList(weekPlan: weekPlan);
                } else {
                  return Center(child: Text('プランが見つかりませんでした'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final weekPlan = await _weekPlanFuture;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingListScreen(weekPlan: weekPlan),
                  ),
                );
              },
              child: Text('買い物リスト'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

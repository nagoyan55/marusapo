import 'package:flutter/material.dart';
import 'package:myapp/logics/plan.dart';
import 'package:myapp/models/week_plan.dart';
import 'package:myapp/widgets/plan_list.dart';
import 'package:myapp/widgets/shopping_list_screen.dart';

class PlanScreen extends StatefulWidget {
  final Future<String> Function(String) loadJsonFunction;

  PlanScreen({required this.loadJsonFunction});

  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late Future<WeekPlan> _weekPlanFuture;
  final DateTime _startDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _weekPlanFuture = loadAndCreatePlan(_startDate);
  }

  Future<WeekPlan> loadAndCreatePlan(DateTime startDate) async {
    String jsonString = await widget.loadJsonFunction('assets/plan.json');
    return createPlanFromJson(jsonString, startDate);
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

import 'package:flutter/material.dart';
import 'package:myapp/logics/plan.dart';
import 'package:myapp/logics/shopping_list.dart';
import 'package:myapp/models/plan.dart';
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

  @override
  void initState() {
    super.initState();
    _weekPlanFuture = loadAndCreatePlan(DateTime.now());
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
      body: FutureBuilder<WeekPlan>(
        future: _weekPlanFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final weekPlan = snapshot.data!;
            return Column(
              children: [
                Expanded(child: PlanList(weekPlan: weekPlan)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      final totalIngredients =
                          calculateTotalIngredients(weekPlan);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShoppingListScreen(
                              totalIngredients: totalIngredients),
                        ),
                      );
                    },
                    child: Text('買い物リスト'),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text('プランが見つかりませんでした'));
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/logics/plan.dart';
import 'package:myapp/models/model.dart';
import 'package:myapp/widgets/shopping_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<String> Function(String) loadJsonFunction;

  MyApp({this.loadJsonFunction = loadJson});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'こんだてまるさぽくん',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(loadJsonFunction: loadJsonFunction),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Future<String> Function(String) loadJsonFunction;

  HomeScreen({required this.loadJsonFunction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('こんだてまるさぽくん'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlanScreen(loadJsonFunction: loadJsonFunction),
              ),
            );
          },
          child: Text('プランを生成'),
        ),
      ),
    );
  }
}

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
                      final totalIngredients = calculateTotalIngredients(weekPlan);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShoppingListScreen(totalIngredients: totalIngredients),
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

class PlanList extends StatelessWidget {
  final WeekPlan weekPlan;

  PlanList({required this.weekPlan});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('yyyy/MM/dd');

    return ListView.builder(
      itemCount: weekPlan.days.length,
      itemBuilder: (context, index) {
        final dayPlan = weekPlan.days[index];
        String formattedDate = dateFormat.format(dayPlan.date);
        return Card(
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$formattedDate (${dayPlan.weekday})', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('朝食: ${dayPlan.breakfast.name}', style: TextStyle(fontSize: 14)),
                Text('昼食: ${dayPlan.lunch.name}', style: TextStyle(fontSize: 14)),
                Text('夕食: ${dayPlan.dinner.name}', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        );
      },
    );
  }
}

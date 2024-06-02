import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/model.dart'; // クラス定義があるファイルをインポート
import 'package:myapp/theme.dart'; // テーマファイルのインポート
import 'package:myapp/logics/plan.dart'; // plan.dart のインポート

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const materialTheme = MaterialTheme(TextTheme());
    return MaterialApp(
      title: 'こんだてまるさぽくん',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
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
              MaterialPageRoute(builder: (context) => PlanScreen()),
            );
          },
          child: Text('プランを生成'),
        ),
      ),
    );
  }
}

class PlanScreen extends StatefulWidget {
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
    String jsonString = await loadJson('assets/plan.json');
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlanTable(weekPlan: snapshot.data!),
            );
          } else {
            return Center(child: Text('プランが見つかりませんでした'));
          }
        },
      ),
    );
  }
}

class PlanTable extends StatelessWidget {
  final WeekPlan weekPlan;

  PlanTable({required this.weekPlan});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('yyyy/MM/dd');

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('日付')),
          DataColumn(label: Text('朝食')),
          DataColumn(label: Text('昼食')),
          DataColumn(label: Text('夕食')),
        ],
        rows: weekPlan.days.map((dayPlan) {
          String formattedDate = dateFormat.format(dayPlan.date);
          return DataRow(cells: [
            DataCell(Text('$formattedDate (${dayPlan.weekday})')),
            DataCell(Text(dayPlan.breakfast.name)),
            DataCell(Text(dayPlan.lunch.name)),
            DataCell(Text(dayPlan.dinner.name)),
          ]);
        }).toList(),
      ),
    );
  }
}

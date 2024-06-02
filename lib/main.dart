import 'package:flutter/material.dart';
import 'package:myapp/models/model.dart'; // クラス定義があるファイルをインポート
import 'package:intl/intl.dart'; // 日付フォーマット用
import 'package:intl/date_symbol_data_local.dart'; // ロケールデータ初期化用
import 'dart:convert'; // JSON操作用
import 'package:flutter/services.dart' show rootBundle;
import 'package:myapp/theme.dart'; // JSONファイル読み込み用

void main() {
  initializeDateFormatting('ja').then((_) {
    runApp(MyApp());
  });
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
        title: Text('こんだてまるさぽくん')
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
    _weekPlanFuture = createPlan();
  }

  Future<WeekPlan> createPlan() async {
    String jsonString = await rootBundle.loadString('assets/plan.json');
    Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
    WeekPlan weekPlan = WeekPlan.fromJson(jsonResponse);
    return weekPlan;
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
    DateFormat dateFormat = DateFormat('yyyy/MM/dd', 'ja');

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

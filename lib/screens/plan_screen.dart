import 'package:flutter/material.dart';
import 'package:myapp/logics/plan.dart';
import 'package:myapp/screens/sign_in_screen.dart';
import 'package:myapp/util/checked_ingredients_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/week_plan.dart';
import '../widgets/plan_list.dart';
import 'shopping_list_screen.dart';
import 'home_screen.dart';

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
    _showTutorialIfFirstTime();
  }

  Future<void> _loadPlan() async {
    WeekPlan? savedPlan = await _firestoreService.loadPlanFromPreferences();
    setState(() {
      if (savedPlan != null) {
        _weekPlanFuture = Future.value(savedPlan);
      } else {
        _weekPlanFuture = _firestoreService.fetchRandomPlanFromFirestore();
      }
    });
  }

  Future<void> _fetchRandomPlanFromFirestore() async {
    await CheckedIngredientsManager.clearCheckedIngredients();
    WeekPlan newPlan = await _firestoreService.fetchRandomPlanFromFirestore();
    setState(() {
      _weekPlanFuture = Future.value(newPlan);
    });
  }

  Future<void> _deletePlan(BuildContext context) async {
    await _firestoreService.deleteSavedPlan();
    await CheckedIngredientsManager.clearCheckedIngredients();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(hasSavedPlan: false)),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _showTutorialIfFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showTutorialDialog();
      });
    }
  }

  void _showTutorialDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('プランを作成しました！'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('この画面では、一週間の献立プランを見ることができます。'),
                SizedBox(height: 10),
                Text('右上の再作成アイコンをタップすると、新しいプランを生成します。'),
                SizedBox(height: 10),
                Text('買い物リストボタンをタップすると、必要な食材のリストを表示します。'),
                SizedBox(height: 10),
                Text('メニューをタップすると、材料とレシピを表示します。'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('閉じる'),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isFirstTime', false);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('献立まるさぽくん'),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'プランを再作成する',
              onPressed: _fetchRandomPlanFromFirestore,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              tooltip: 'プランを削除する',
              onPressed: () => _deletePlan(context),
            ),
            IconButton(
              icon: Icon(Icons.logout),
              tooltip: 'サインアウト',
              onPressed: () async {
                await authService.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
            ),
          ],
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
              final weekPlanWithDate = setDates(weekPlan, DateTime.now());
              return Column(
                children: [
                  Expanded(
                    child: PlanList(weekPlan: weekPlanWithDate),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShoppingListScreen(weekPlan: weekPlanWithDate),
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
              );
            } else {
              return Center(child: Text('プランが見つかりませんでした'));
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/logics/plan.dart';
import 'package:myapp/screens/sign_in_screen.dart';
import 'package:myapp/util/checked_ingredients_manager.dart';
import 'package:provider/provider.dart';
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

  Future<void> _fetchPlanFromFirestore() async {
    await CheckedIngredientsManager.clearCheckedIngredients();
    WeekPlan newPlan = await _firestoreService.fetchPlansFromFirestore();
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

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('こんだてまるさぽくん'),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'プランを再作成する',
              onPressed: _fetchPlanFromFirestore,
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

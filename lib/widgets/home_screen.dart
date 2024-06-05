import 'package:flutter/material.dart';
import 'package:myapp/widgets/plan_screen.dart';

class HomeScreen extends StatelessWidget {
  final bool hasSavedPlan;

  HomeScreen({required this.hasSavedPlan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('こんだてまるさぽくん'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(40),
            minimumSize: Size(160, 160),
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PlanScreen()),
              (Route<dynamic> route) => false,
            );
          },
          child: Text(hasSavedPlan ? 'プランを見る' : 'プラン作成', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

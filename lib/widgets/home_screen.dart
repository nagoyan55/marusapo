import 'package:flutter/material.dart';
import 'package:myapp/widgets/plan_screen.dart';

class HomeScreen extends StatelessWidget {
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlanScreen(),
              ),
            );
          },
          child: Text('プラン作成', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

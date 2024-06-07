import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('サインイン'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '献立まるさぽくんです',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '毎日の献立を簡単に作成！\nあなたの食卓をまるごとサポートします',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                icon: Icon(Icons.person),
                label: Text('匿名でサインイン'),
                onPressed: () async {
                  await authService.signInAnonymously();
                  bool hasSavedPlan = await authService.hasSavedPlan;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(hasSavedPlan: hasSavedPlan),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.account_circle),
                label: Text('Googleでサインイン'),
                onPressed: () async {
                  try {
                    await authService.signInWithGoogle();
                    bool hasSavedPlan = await authService.hasSavedPlan;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(hasSavedPlan: hasSavedPlan),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Googleサインインに失敗しました: $e')),
                    );
                  }
                },
              ),
              SizedBox(height: 40),
              Text(
                '作成者: @ikashoppin',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

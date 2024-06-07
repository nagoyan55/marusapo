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
        title: Text('献立まるさぽくん'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
          ],
        ),
      ),
    );
  }
}

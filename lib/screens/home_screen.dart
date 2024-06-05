import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import 'sign_in_screen.dart';
import 'plan_screen.dart';

class HomeScreen extends StatelessWidget {
  final bool hasSavedPlan;

  HomeScreen({required this.hasSavedPlan});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('こんだてまるさぽくん'),
        actions: [
          if (user != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(child: Text(user.displayName ?? 'ゲスト')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                backgroundImage: user.photoURL != null
                    ? NetworkImage(user.photoURL!)
                    : AssetImage('assets/default_user_icon.png') as ImageProvider,
              ),
            ),
          ],
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              print("Logout button pressed");
              try {
                await authService.signOut();
                print("User signed out, current user: ${authService.currentUser}");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              } catch (e) {
                print("Error signing out: $e");
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_forever),
            tooltip: 'ローカルデータを削除します',
            onPressed: () async {
              bool confirmed = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('確認'),
                    content: Text('ローカルデータをすべて削除しますか？'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('キャンセル'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('削除'),
                      ),
                    ],
                  );
                },
              );
              if (confirmed) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('ローカルデータが削除されました')),
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
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
          ],
        ),
      ),
    );
  }
}

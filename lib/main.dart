import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widgets/plan_screen.dart';
import 'package:myapp/services/firestore_service.dart';
import 'package:myapp/widgets/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ローカルにプランがあるかどうかを確認
  FirestoreService firestoreService = FirestoreService();
  bool hasSavedPlan = await firestoreService.hasSavedPlan();

  runApp(MyApp(hasSavedPlan: hasSavedPlan));
}

class MyApp extends StatelessWidget {
  final bool hasSavedPlan;

  MyApp({required this.hasSavedPlan});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'こんだてまるさぽくん',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: hasSavedPlan ? PlanScreen() : HomeScreen(),
    );
  }
}

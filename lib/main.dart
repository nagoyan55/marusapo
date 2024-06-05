import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widgets/plan_screen.dart';
import 'package:myapp/util/json_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<String> Function(String) loadJsonFunction;

  MyApp({this.loadJsonFunction = loadJson});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'こんだてまるさぽくん',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(loadJsonFunction: loadJsonFunction),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Future<String> Function(String) loadJsonFunction;

  HomeScreen({required this.loadJsonFunction});

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
                builder: (context) => PlanScreen(loadJsonFunction: loadJsonFunction),
              ),
            );
          },
          child: Text('プラン作成', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

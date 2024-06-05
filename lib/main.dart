import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:myapp/screens/plan_screen.dart';
import 'package:myapp/services/auth_service.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'services/firestore_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        title: 'こんだてまるさぽくん',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder<bool>(
          future: _checkSavedPlan(),
          builder: (context, snapshot) {
            final authService = Provider.of<AuthService>(context);
            final user = authService.currentUser;
            if(user == null){
              return SignInScreen();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data == true) {
              return PlanScreen();
            } else {
              return HomeScreen(hasSavedPlan: snapshot.data == true);
            }
          },
        ),
      ),
    );
  }

  Future<bool> _checkSavedPlan() async {
    final firestoreService = FirestoreService();
    return await firestoreService.hasSavedPlan();
  }
}

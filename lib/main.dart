import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'screens/home_screen.dart';
import 'screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
      ],
      child: Consumer<AuthService>(
        builder: (context, authService, _) {
          return MaterialApp(
            title: 'こんだてまるさぽくん',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: FutureBuilder<bool>(
              future: authService.hasSavedPlan,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('エラーが発生しました: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data == true) {
                  return HomeScreen(hasSavedPlan: true);
                } else {
                  return SignInScreen();
                }
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studee_app/data/database.dart';
import 'package:studee_app/screens/auth_screen.dart';
import 'package:studee_app/screens/main_screen.dart';
import 'package:studee_app/screens/onboardingscreen.dart';
import 'package:studee_app/screens/waitingScreen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool firstSignUp = false;
  bool isDone = false;

  void firstSignUpDone(bool x) {
    setState(() {
      firstSignUp = true;
    });
  }

  void done() {
    setState(() {
      isDone = true;
    });
  }

  void firstSignUpNo() {
    setState(() {
      firstSignUp = false;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studee',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0x007300ff)),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 24),
          titleMedium: TextStyle(fontSize: 12),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, result) {
          if (!result.hasData && firstSignUp == false) {
            return AuthScreen(onTrue: firstSignUpDone);
          }
          if (result.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (firstSignUp) {
            return WaitingScreen(
              onVerified: () {
                setState(() {
                  firstSignUp = false;
                });
              },
            );
          }

          if (!isDone) {
            return OnboardingScreen(done: done);
          }
          return MainScreen();
        },
      ),
    );
  }
}

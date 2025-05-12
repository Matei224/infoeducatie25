import 'package:flutter/material.dart';
import 'package:studee_app/screens/auth_screen.dart';
import 'package:studee_app/screens/main_screen.dart';
import 'package:studee_app/screens/onboardingscreen.dart';
import 'package:studee_app/screens/presents/pagewidgetmodal.dart';
import 'package:studee_app/widgets/form_budget.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  bool firstSignUp = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studee',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0x7300FF)),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 24),
          titleMedium: TextStyle(fontSize: 12),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, result) {
          if (!result.hasData && firstSignUp == false) {
            return AuthScreen(firstSignUp: firstSignUp);
          }
          if (firstSignUp) return OnboardingScreen();

          return MainScreen();
        },
      ),
    );
  }
}

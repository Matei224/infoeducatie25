import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:studee_app/data/database.dart';
import 'package:studee_app/model/filterchipitem.dart';
import 'package:studee_app/model/university.dart';
import 'package:studee_app/screens/auth_screen.dart';
import 'package:studee_app/screens/main_screen.dart';
import 'package:studee_app/screens/onboardingscreen.dart';
import 'package:studee_app/screens/waitingScreen.dart';
import 'package:studee_app/services/api_services.dart';
import 'firebase_options.dart';

late final List<SelectedListItem<String>> names;
List<FilterChipItem>? countriesFilter;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  await initializeFilters();
  await initializeNameUnivs(); // Populate filters from database  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(MyApp()));
}

Future<void> initializeFilters() async {
  final universities = await DatabaseHelper.instance.getUniversities();
  countriesFilter = universities.map((u) => u.country).toSet().map((country) => FilterChipItem(label: country, value: country)).toList();
}

Future<void> initializeNameUnivs() async {
  final universities = await DatabaseHelper.instance.getUniversities();
  names = universities.map((u) => u.name).toSet().map((name) => SelectedListItem<String>(data: name)).toList();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, authSnapshot) {
          if (authSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!authSnapshot.hasData) {
            return AuthScreen(onTrue: (bool x) {  },);
          }
          final user = authSnapshot.data!;
          if (!user.emailVerified) {
            return WaitingScreen(
              onCheckVerification: () async {
                await user.reload();
                if (user.emailVerified) {
                  setState(() {});
                }
              }, onVerified: () {  },
            );
          }
          return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
            builder: (ctx, docSnapshot) {
              if (docSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              final data = docSnapshot.data?.data() as Map<String, dynamic>?;
              if (data?['onboardingCompleted'] == true) {
                return MainScreen();
              } else {
                return OnboardingScreen();
              }
            },
          );
        },
      ),
    );
  }
}

final List<FilterChipItem> programmeFilter = [
  "Computer Science",
  "Mechanical Engineering",
  "Electrical Engineering",
  "Biology",
  "Chemistry",
  "Physics",
  "Mathematics",
  "Economics",
  "Business Administration",
  "Psychology",
  "Sociology",
  "History",
  "Philosophy",
  "English Literature",
  "Foreign Languages",
  "Civil Engineering",
  "Chemical Engineering",
  "Aerospace Engineering",
  "Biomedical Engineering",
  "Environmental Engineering",
  "Industrial Engineering",
  "Materials Science and Engineering",
  "Nuclear Engineering",
  "Petroleum Engineering",
  "Software Engineering",
  "Biochemistry",
  "Microbiology",
  "Molecular Biology",
  "Genetics",
  "Neuroscience",
  "Ecology",
  "Geology",
  "Astronomy",
  "Statistics",
  "Actuarial Science",
  "Accounting",
  "Finance",
  "Marketing",
  "Management",
  "International Business",
  "Human Resource Management",
  "Political Science",
  "International Relations",
  "Anthropology",
  "Archaeology",
  "Geography",
  "Linguistics",
  "Literature",
  "Creative Writing",
  "Journalism",
  "Media Studies",
  "Communication Studies",
  "Film Studies",
  "Theatre Arts",
  "Music",
  "Fine Arts",
  "Graphic Design",
  "Architecture",
  "Urban Planning",
  "Law",
  "Education",
  "Nursing",
  "Public Health",
  "Pharmacy",
  "Dentistry",
  "Medicine",
  "Veterinary Medicine",
  "Agriculture",
  "Forestry",
  "Environmental Science",
  "Marine Biology",
  "Oceanography",
  "Meteorology",
  "Astrophysics",
  "Quantum Physics",
  "Theoretical Physics",
  "Applied Mathematics",
  "Pure Mathematics",
  "Operations Research",
  "Supply Chain Management",
  "Entrepreneurship",
  "Social Work",
  "Criminology",
  "Gender Studies",
  "Cultural Studies",
  "Religious Studies",
  "Ethics",
  "Logic",
  "Aesthetics",
  "Epistemology",
  "Metaphysics"
].map((prog) => FilterChipItem(label: prog, value: prog)).toList();

final List<FilterChipItem> budgetFilter = [
  "Free",
  "Priced"
].map((prog) => FilterChipItem(label: prog, value: prog)).toList();
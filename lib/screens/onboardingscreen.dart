import 'package:flutter/material.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/form_universities.dart';
import 'package:studee_app/model/budget.dart';
import 'package:studee_app/model/mood.dart';
import 'package:studee_app/model/profileModel.dart';
import 'package:studee_app/screens/presents/pages/page1.dart';
import 'package:studee_app/screens/presents/pages/page2.dart';
import 'package:studee_app/screens/presents/pages/page3.dart';
import 'package:studee_app/screens/presents/pages/page4.dart';
import 'package:studee_app/screens/presents/pages/page5.dart';
import 'package:studee_app/screens/presents/pages/page6.dart';
import 'package:studee_app/screens/presents/pages/page7.dart';
import 'package:studee_app/screens/presents/pages/page8.dart';
import 'package:studee_app/screens/presents/pages/page9.dart';
import 'package:studee_app/widgets/form_birthday.dart';
import 'package:studee_app/widgets/form_budget.dart';
import 'package:studee_app/widgets/form_dropdown_list.dart';
import 'package:studee_app/widgets/form_field_introduction.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:studee_app/widgets/form_mood.dart';
import 'package:studee_app/widgets/form_mood_toggle.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:animated_icon/animated_icon.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  final int totalPages = 9;

  List<Widget> pages = [];
  ProfileModel person = ProfileModel();

  @override
  void initState() {
    super.initState();
    person.budget = null;
    person.mood = Mood.excited;
    person.myGender = Gender.Male;
    person.gpa = 2.0;
    pages = [
      Page1(),
      Page12Name(
        form: _form1,
        setFirstName: person.setFirstName,
        setLastName: person.setLastName,
      ),
      Page2Gender(setGender: person.setGender),
      Page3Birth(form: _form2),
      Page4Interest(form: _form3, setInterest: person.setInterest),
      Page5Univ(setUnivs: person.setUnivs, form: _form4),
      Page6GPA(setGPA: person.setGPA),
      Page7Budget(form: _form5, setBudget: person.setBudget),
      Page8Mood(setMood: person.setMood),
    ];
  }

  final _form1 = GlobalKey<FormState>();
  final _form2 = GlobalKey<FormState>();
  final _form3 = GlobalKey<FormState>();
  final _form4 = GlobalKey<FormState>();
  final _form5 = GlobalKey<FormState>();

  void nextPage() {
    switch (currentPage) {
      case 0:
        if (currentPage < totalPages - 1) {
          setState(() {
            currentPage++;
          });
        }
        break;

      case 1:
        FormState? exist = _form1.currentState;
        bool isValid = _form1.currentState!.validate();
        if (isValid) {
          _form1.currentState!.save();
          print('${person.lastName}');
          print('${person.firstName}');

          if (currentPage < totalPages - 1) {
            setState(() {
              currentPage++;
            });
          }
        }
        break;

      case 2:
        if (currentPage < totalPages - 1) {
          print('${person.myGender}');

          setState(() {
            currentPage++;
          });
        }
        break;

      case 3:
        FormState? exist = _form2.currentState;
        bool isValid = _form2.currentState!.validate();
        if (isValid) {
          if (currentPage < totalPages - 1) {
            setState(() {
              currentPage++;
            });
          }
        }
        break;

      case 4:
        FormState? exist = _form3.currentState;
        bool isValid = _form3.currentState!.validate();
        if (isValid) {
          print('${person.mySubjectOfInterest}');

          if (currentPage < totalPages - 1) {
            setState(() {
              currentPage++;
            });
          }
        }
        break;

      case 5:
        FormState? exist = _form4.currentState;
        bool isValid = _form4.currentState!.validate();
        if (isValid) {
          print('${person.chosenUniversities}');

          if (currentPage < totalPages - 1) {
            setState(() {
              currentPage++;
            });
          }
        }
        break;

      case 6:
        if (currentPage < totalPages - 1) {
          print('${person.gpa}');

          setState(() {
            currentPage++;
          });
        }

        break;

      case 7:
        if (person.budget == null) {
          FormState? exist = _form5.currentState;
          bool isValid = _form5.currentState!.validate();
          if (isValid) {
            _form5.currentState!.save();
            print('${person.budget}');

            if (currentPage < totalPages - 1) {
              setState(() {
                currentPage++;
              });
            }
          }
        } else {
          if (currentPage < totalPages - 1) {
            setState(() {
              currentPage++;
            });
          }
        }

        break;

      case 8:
        if (currentPage < totalPages - 1) {
          print('${person.mood}');

          setState(() {
            currentPage++;
          });
        }

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('Current page : $currentPage');
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 115, 0, 255),
      body: Row(
        children: [
          // Progress bar with animated circle
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.03),
            child: Container(
              width: 20,
              height: size.height * 0.8,
              child: Stack(
                children: [
                  // The vertical bar
                  Positioned(
                    left: 9,
                    child: Container(
                      width: 2,
                      height: size.height * 0.8,
                      color: Colors.white,
                    ),
                  ),
                  // The animated circle
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    top:
                        (currentPage / (totalPages - 1)) *
                        (size.height * 0.8 - 20),
                    left: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main content with fading text and swipe button
          Expanded(
            child: Stack(
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: pages[currentPage],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.12,
                    right: size.width * 0.18,
                    bottom: size.height * 0.05,
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: GestureDetector(
                        onPanUpdate: (e) {
                          if (e.delta.dy < -5) {
                            nextPage();
                          }
                        },

                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Swipe",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gender_picker/source/gender_picker.dart';

import 'package:studee_app/screens/presents/pagewidgetmodal.dart';

import 'package:gender_picker/source/enums.dart';

class Page2Gender extends StatelessWidget {
  Page2Gender({super.key, required this.setGender});
  void Function(Gender x) setGender;

  @override
  Widget build(BuildContext context) {
    return PageWidgetModal(
      text: "What's your gender?",
      studee: "",

      span: "",
      swipe: "Next question",
      form_gender: GenderPickerWithImage(
        showOtherGender: true,
        verticalAlignedText: false,
        selectedGender: Gender.Male,
        selectedGenderTextStyle: TextStyle(
          color: Color(0xFF8b32a8),
          fontWeight: FontWeight.bold,
        ),
        unSelectedGenderTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
        onChanged: (Gender? gender) {
          setGender(gender!);
        },
        equallyAligned: true,
        animationDuration: Duration(milliseconds: 300),
        isCircular: true,
        opacityOfGradient: 0.4,
        padding: const EdgeInsets.all(3),
        size: 90, 
      ),
    );
  }
}

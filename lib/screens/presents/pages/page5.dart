import 'package:flutter/material.dart';
import 'package:gender_picker/source/gender_picker.dart';

import 'package:studee_app/screens/presents/pagewidgetmodal.dart';

import 'package:gender_picker/source/enums.dart';
import 'package:studee_app/widgets/form_dropdown_list.dart';

class Page4Interest extends StatelessWidget {
  Page4Interest({super.key, required this.form, required this.setInterest});
  final form;
  String? mySubjectOfInterest;
  void Function(String? x) setInterest;

  @override
  Widget build(BuildContext context) {
    return PageWidgetModal(
      text: "What's your subject of interest?",
      studee: "",

      span: "",
      swipe: "Next question",
      form_interest: FormDropDown(
        setInterest: setInterest,
        form: form,
        labelText: 'Select one or more below',
        mySubjectOfInterest: mySubjectOfInterest,
      ),
    );
  }
}

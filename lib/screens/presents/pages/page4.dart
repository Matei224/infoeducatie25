import 'package:flutter/material.dart';
import 'package:gender_picker/source/gender_picker.dart';

import 'package:studee_app/screens/presents/pagewidgetmodal.dart';

import 'package:gender_picker/source/enums.dart';
import 'package:studee_app/widgets/form_birthday.dart';

class Page3Birth extends StatelessWidget {
  const Page3Birth({super.key, required this.form});
  final form;
  @override
  Widget build(BuildContext context) {
    return PageWidgetModal(
      text: "When is your birthday?",
      studee: "",

      span: "",
      swipe: "Next question",
      form_birth: FormBirthday(labelText: 'MM/YY/DD', form: form),
    );
  }
}

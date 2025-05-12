import 'package:flutter/material.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/form_universities.dart';
import 'package:studee_app/screens/presents/pagewidgetmodal.dart';
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

class Page12Name extends StatelessWidget {
  Page12Name({
    super.key,
    this.form,
    required this.setFirstName,
    required this.setLastName,
  });
  final form;
  void Function(String x) setFirstName;
  void Function(String x) setLastName;

  @override
  Widget build(BuildContext context) {
    return PageWidgetModal(
      text: "How should we call you?",
      studee: "",
      form_key_name: form,
      span: "",
      swipe: "Next question",
      form1: FormIntroduction(labelText: "First name", setName: setFirstName),
      form2: FormIntroduction(labelText: "Last name", setName: setLastName),
    );
  }
}

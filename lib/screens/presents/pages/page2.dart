import 'package:flutter/material.dart';
import 'package:studee_app/screens/presents/pagewidgetmodal.dart';
import 'package:studee_app/widgets/form_field_introduction.dart';

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

import 'package:flutter/material.dart';

import 'package:studee_app/screens/presents/pagewidgetmodal.dart';

import 'package:studee_app/widgets/form_budget.dart';

class Page7Budget extends StatelessWidget {
  Page7Budget({super.key, required this.form, required this.setBudget});

  final form;
  void Function(dynamic x) setBudget;
  @override
  Widget build(BuildContext context) {
    return PageWidgetModal(
      text: "What would your budget be?",
      studee: "",

      span: "",
      swipe: "Next question",
      formBudget: FormBudget(form: form, setBudget: setBudget),
    );
  }
}

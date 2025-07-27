import 'package:flutter/material.dart';
import 'package:studee_app/widgets/form_universities.dart';

import 'package:studee_app/screens/presents/pagewidgetmodal.dart';


class Page5Univ extends StatelessWidget {
  Page5Univ({super.key, required this.setUnivs, required this.form});
  void Function(List<String>? x) setUnivs;
  final form;
  @override
  Widget build(BuildContext context) {
    return PageWidgetModal(
      text: "What are your top 3 universities?",
      studee: "",

      span: "",
      swipe: "Next question",
      form_universities: FormUniversities(
        form: form,
        setUnivs: setUnivs,
        labelText: 'Search below',
      ),
    );
  }
}

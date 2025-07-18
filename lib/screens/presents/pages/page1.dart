import 'package:flutter/material.dart';
import 'package:studee_app/screens/presents/pagewidgetmodal.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});
  @override
  Widget build(BuildContext context) {
    return PageWidgetModal(
      text: "We're building your space inside ",
      studee: "Studee!",
      span: "",
      swipe: "Swipe",
    );
  }
}

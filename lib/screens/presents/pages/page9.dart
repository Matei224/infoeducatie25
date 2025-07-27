import 'package:flutter/material.dart';
import 'package:studee_app/model/mood.dart';

import 'package:studee_app/screens/presents/pagewidgetmodal.dart';

import 'package:studee_app/widgets/form_mood.dart';

class Page8Mood extends StatelessWidget {
  Page8Mood({super.key, required this.setMood,required this.move});
  void Function(Mood? x) setMood;
    
  void Function(bool x) move;


  @override
  Widget build(BuildContext context) {
    return PageWidgetModal(
      text: "How do you feel about going to university?",
      studee: "",

      span: "",
      swipe: "Next question",
      formMood: FormMood(setMood: setMood,move: move,),
    );
  }
}

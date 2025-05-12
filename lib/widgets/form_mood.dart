import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/model/budget.dart';
import 'package:studee_app/model/mood.dart';
import 'package:studee_app/widgets/form_budget_toggle.dart';
import 'package:studee_app/widgets/form_mood_toggle.dart';
import 'package:studee_app/widgets/form_own_budget.dart';

class FormMood extends StatefulWidget {
  FormMood({super.key, required this.setMood});
  Mood? mood;
  void Function(Mood? x) setMood;

  @override
  State<FormMood> createState() => _FormMoodState();
}

class _FormMoodState extends State<FormMood> {
  TextEditingController _text = TextEditingController();
  List<bool> selectionsi = [true, false, false, false];
  List<Mood> moods = [Mood.excited, Mood.happy, Mood.fine, Mood.nervous];
  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ToggleButtons(
          selectedColor: Color.fromARGB(255, 115, 0, 255),
          renderBorder: false,
          borderWidth: 0,
          borderColor: Color.fromARGB(0, 0, 0, 0),
          fillColor: Color.fromARGB(255, 115, 0, 255),
          direction: Axis.vertical,
          children: [
            FormMoodToggle(
              labelText: 'Excited!',
              value: ValueKey(Mood.excited),
            ),
            FormMoodToggle(labelText: 'Happy', value: ValueKey(Mood.happy)),
            FormMoodToggle(labelText: 'Fine', value: ValueKey(Mood.fine)),

            FormMoodToggle(labelText: 'Nervous', value: ValueKey(Mood.nervous)),
          ],
          isSelected: selectionsi,
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < selectionsi.length; i++) {
                if (i == index) {
                  widget.mood = moods[i];
                  widget.setMood(moods[i]);
                  selectionsi[i] = true;
                } else {
                  selectionsi[i] = false;
                }
              }
            });
          },
        ),
      ],
    );
  }
}

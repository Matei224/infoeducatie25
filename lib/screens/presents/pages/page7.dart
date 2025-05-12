import 'package:flutter/material.dart';
import 'package:gender_picker/source/gender_picker.dart';

import 'package:studee_app/screens/presents/pagewidgetmodal.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:animated_icon/animated_icon.dart';
import 'package:gender_picker/source/enums.dart';

class Page6GPA extends StatefulWidget {
  Page6GPA({super.key, required this.setGPA});
  double gpa = 2.0;
  void Function(double? x) setGPA;
  @override
  State<Page6GPA> createState() => _Page6GPAState();
}

class _Page6GPAState extends State<Page6GPA> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return PageWidgetModal(
      text: "What's your GPA?",
      span: "",
      studee: "",
      swipe: "Next question",
      subtext: "Grade Point Average",
      sliderTheme: SizedBox(
        width: 300,
        child: SfSliderTheme(
          data: SfSliderThemeData(
            activeTrackHeight: 10,
            inactiveTrackHeight: 10,
            activeDividerRadius: 5,
            inactiveDividerRadius: 5,
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.white,
            activeDividerColor: Color.fromARGB(
              255,
              115,
              0,
              255,
            ), // Circles as purple dividers
            inactiveDividerColor: Color.fromARGB(
              255,
              115,
              0,
              255,
            ), // Consistent divider color
            thumbColor: Color.fromARGB(
              255,
              115,
              0,
              255,
            ), // Thumb matches dividers
            thumbStrokeWidth: 2.0, // Border around thumb
            thumbStrokeColor: Colors.white, // White border for contrast
            thumbRadius: 10,
            // Slightly larger thumb for visibility
          ),
          child: SfSlider(
            min: 2.0,
            max: 5.0,
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
                widget.gpa = value;
                widget.setGPA(widget.gpa);
              });
            },
            stepSize: 0.375, // Ensures snapping to discrete steps
            interval: 0.375, // Places dividers at each step
            showDividers: true,
            enableTooltip: true, // Displays dividers as dots
          ),
        ),
      ),
    );
  }
}

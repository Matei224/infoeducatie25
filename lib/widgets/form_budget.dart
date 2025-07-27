import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/model/budget.dart';
import 'package:studee_app/widgets/form_budget_toggle.dart';
import 'package:validators/validators.dart';

class FormBudget extends StatefulWidget {
  FormBudget({super.key, required this.form, required this.setBudget});
  var budget;
  final form;
  void Function(dynamic x) setBudget;

  @override
  State<FormBudget> createState() => _FormBudgetState();
}

class _FormBudgetState extends State<FormBudget> {
  final TextEditingController _text = TextEditingController();
  String labelText = '';
  List<bool> selections = [true, false, false];
  List<Budget> budget = [
    Budget.zero,
    Budget.lessThan1k,
    Budget.medium5k,
    Budget.moreThan10k,
  ];
  int number = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Select a range from below"),
          ToggleButtons(
            selectedColor: Color.fromARGB(255, 115, 0, 255),
            renderBorder: false,
            borderWidth: 0,
            borderColor: Color.fromARGB(255, 115, 0, 255),
            fillColor: Color.fromARGB(255, 115, 0, 255),
            direction: Axis.vertical,
            isSelected: selections,
            onPressed: (int index) {
              setState(() {
                labelText = '';

                for (int i = 0; i < selections.length; i++) {
                  if (i == index) {
                    widget.setBudget(budget[i]);
                    selections[i] = true;
                    number = i;
                  } 
                }
              });
            },
            children: [
              FormBudgetToggle(labelText: '0', value: ValueKey(Budget.zero)),
              FormBudgetToggle(
                labelText: '<1000',
                value: ValueKey(Budget.lessThan1k),
              ),
              FormBudgetToggle(
                labelText: '>5000',
                value: ValueKey(Budget.medium5k),
              ),
            ],
          ),
          Text("Or type your own"),
          Container(
            height: 30,
            width: size.width * 0.5,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.2),
              borderRadius: BorderRadius.circular(8.0), // Uniform radius
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Form(
                key: widget.form,
                child: TextFormField(
                  onTap: () {
                    setState(() {
                      for (int i = 0; i < selections.length; i++) {
                        selections[i] = false;
                      }
                    });
                    widget.setBudget(null);
                  },
                  decoration: InputDecoration(
                    labelText: labelText,
                    suffixText: "\$",
                    suffixStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter an amount';
                    }
                    if (val[0] == '0' || !isNumeric(val)) {
                      return 'Invalid amount';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    widget.setBudget(newValue);
                    labelText = newValue!;
                    selections[number] = false;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

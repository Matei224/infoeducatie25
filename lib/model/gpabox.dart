import 'package:flutter/material.dart';

class GpaBox extends StatefulWidget {
  GpaBox({
    super.key,
    required this.form,
    required this.gpa,
    required this.isEdit,
    required this.setGpa,
    required this.setEdit,
  });
  bool isEdit = false;
  String gpa;
  final form;
  void Function(String gpa) setGpa;
  void Function(bool isEdit) setEdit;
  @override
  State<GpaBox> createState() => _GpaBoxState();
}

class _GpaBoxState extends State<GpaBox> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String? validateNumber(String? value) {
      // Check if the input is null or empty
      if (value == null || value.isEmpty) {
        return 'Please enter a number.';
      }

      // Attempt to parse the string as a double
      double? number = double.tryParse(value);
      if (number == null) {
        return 'Please enter a valid number.';
      }

      // Check if the number is within the range [2.0, 4.0]
      if (number < 2.0 || number > 4.0) {
        return 'Please enter a number between 2.0 and 4.0.';
      }

      // If all checks pass, return null (valid input)
      return null;
    }

    return Container(
      height: 50,
      width: size.width * 0.53,

      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 234, 218, 255),
          width: 0.6,
        ),
        color: Color.fromARGB(255, 234, 218, 255),
        borderRadius: BorderRadius.circular(8.0), // Uniform radius
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !widget.isEdit
              ? TextButton(
                child: Text(widget.gpa.toString()),
                onPressed: () {
                  setState(() {
                    widget.isEdit = true;
                  });
                },
              )
              : Form(
                key: widget.form,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter your GPA",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  validator: (e) {
                    validateNumber(e);
                    return null;
                  },
                  onSaved: (e) {
                    setState(() {
                      widget.setGpa(e!);
                    });
                  },
                ),
              ),
        ],
      ),
    );
  }
}

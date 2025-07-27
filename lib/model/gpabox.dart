import 'package:flutter/material.dart';

class GpaBox extends StatefulWidget {
  final GlobalKey<FormState> form;
  final String gpa;
  final bool isEdit;
  final void Function(String gpa) setGpa;
  final void Function(bool isEdit) setEdit;

  const GpaBox({
    super.key,
    required this.form,
    required this.gpa,
    required this.isEdit,
    required this.setGpa,
    required this.setEdit,
  });

  @override
  State<GpaBox> createState() => _GpaBoxState();
}

class _GpaBoxState extends State<GpaBox> {
  late TextEditingController _gpaController;

  @override
  void initState() {
    super.initState();
    _gpaController = TextEditingController(text: widget.gpa);
  }

  @override
  void didUpdateWidget(covariant GpaBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.gpa != oldWidget.gpa) {
      _gpaController.text = widget.gpa;
    }
  }

  @override
  void dispose() {
    _gpaController.dispose();
    super.dispose();
  }

  String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a number.';
    }
    double? number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number.';
    }
    if (number < 2.0 || number > 4.0) {
      return 'Please enter a number between 2.0 and 4.0.';
    }
    return null;
  }

  void _toggleEditMode() {
    if (widget.isEdit) {
      if (widget.form.currentState!.validate()) {
        widget.form.currentState!.save();
        widget.setEdit(false);
      }
    } else {
      widget.setEdit(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: size.width * 0.53,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 234, 218, 255),
          width: 0.6,
        ),
        color: Color.fromARGB(255, 234, 218, 255),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.isEdit
              ? Expanded(
                  child: Form(
                    key: widget.form,
                    child: TextFormField(
                      controller: _gpaController,
                      decoration: InputDecoration(
                        hintText: "Enter your GPA",
                        labelText: "Enter GPA",
                        labelStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: validateNumber,
                      onSaved: (value) {
                        if (value != null) {
                          widget.setGpa(value);
                        }
                      },
                    ),
                  ),
                )
              : TextButton(
                  onPressed: _toggleEditMode,
                  child: Text(widget.gpa.toString()),
                ),
        ],
      ),
    );
  }
}
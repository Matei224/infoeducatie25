import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

class FormBirthday extends StatefulWidget {
  FormBirthday({super.key, required this.labelText, required this.form});
  final String? labelText;
  final form;

  @override
  State<FormBirthday> createState() => _FormBirthdayState();
}

class _FormBirthdayState extends State<FormBirthday> {
  String? enteredUsername;

  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = pickedDate.toString().split(" ")[0];
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 60,
      width: size.width * 0.68,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.2),
        borderRadius: BorderRadius.circular(8.0), // Uniform radius
      ),
      child: Form(
        key: widget.form,
        child: TextFormField(
          controller: _dateController,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(color: Colors.white, fontSize: 16),
          ),
          decoration: InputDecoration(
            hintText: widget.labelText,
            hintStyle: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 16,
              ),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(10.0),
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
          keyboardType: TextInputType.name,
          autocorrect: false,

          textCapitalization: TextCapitalization.none,
          onTap: () {
            _selectDate(context);
          },
          validator: (val) {
            if (_dateController.text == null || _dateController.text.isEmpty) {
              return 'Please enter a date';
            }
            return null;
          },
        ),
      ),
    );
  }
}

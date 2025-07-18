import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';

class FormIntroduction extends StatefulWidget {
  FormIntroduction({super.key, required this.labelText, required this.setName});
  final String? labelText;
  String? enteredUsername;
  String? name;
  void Function(String x) setName;
  @override
  State<FormIntroduction> createState() => _FormIntroductionState();
}

class _FormIntroductionState extends State<FormIntroduction> {
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
      child: TextFormField(
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
        ),
        keyboardType: TextInputType.name,
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        validator: (val) {
          if (val == null || val.isEmpty) return 'Please enter your name';

          if (!isUppercase(val[0])) {
            return "Name can't start with a lower case.";
          }

          if (!isAlpha(val)) {
            return "Name can contain only letters";
          }
          return null;
        },
        onSaved: (value) {
          widget.name = value;
          widget.setName(value!);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormAuthUsername extends StatefulWidget {
  FormAuthUsername({
    super.key,
    required this.icon,
    required this.labelText,
    required this.getter,
  });
  final Icon? icon;
  final String? labelText;
  String? enteredUsername;
  String? Function(String x) getter;

  @override
  State<FormAuthUsername> createState() => _FormAuthUsernameState();
}

class _FormAuthUsernameState extends State<FormAuthUsername> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 60,
      width: size.width * 0.68,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.2),
        borderRadius: BorderRadius.circular(8.0), 
      ),
      child: TextFormField(
        style: GoogleFonts.raleway(
          textStyle: TextStyle(
            color: Color.fromARGB(200, 0, 0, 0),
            fontSize: 16,
          ),
        ),
        decoration: InputDecoration(
          labelText: widget.labelText,
          icon: Padding(padding: EdgeInsets.only(left: 10), child: widget.icon),
          labelStyle: GoogleFonts.raleway(
            textStyle: TextStyle(
              color: Color.fromARGB(100, 0, 0, 0),
              fontSize: 16,
            ),
          ),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        validator: (val) {
          if (val == null || val.isEmpty) return 'Please enter an username';

          return null;
        },
        onSaved: (value) {
          widget.getter(value!.trim());
        },
      ),
    );
  }
}

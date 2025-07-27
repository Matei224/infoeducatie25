import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormAuth extends StatelessWidget {
  const FormAuth({super.key, required this.icon, required this.labelText});
  final Icon? icon;
  final String? labelText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 260,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.2),
        borderRadius: BorderRadius.circular(8.0), 
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          icon: Padding(padding: EdgeInsets.only(left: 10), child: icon),
          labelStyle: GoogleFonts.raleway(
            textStyle: TextStyle(
              color: Color.fromARGB(100, 0, 0, 0),
              fontSize: 16,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

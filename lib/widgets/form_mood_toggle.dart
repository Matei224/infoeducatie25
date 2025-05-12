import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormMoodToggle extends StatelessWidget {
  const FormMoodToggle({
    super.key,
    required this.labelText,
    required this.value,
  });
  final String? labelText;
  final ValueKey? value;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      key: value,
      height: 30,
      width: size.width * 0.5,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.2),
        borderRadius: BorderRadius.circular(8.0), // Uniform radius
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              labelText!,
              style: GoogleFonts.raleway(textStyle: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

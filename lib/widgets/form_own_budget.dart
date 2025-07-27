import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormBudgetType extends StatelessWidget {
  const FormBudgetType({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 30,
      width: size.width * 0.5,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.2),
        borderRadius: BorderRadius.circular(8.0), 
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Your budget"),
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16,
                ),
              ),
            ),
            Text(r'$'),
          ],
        ),
      ),
    );
  }
}

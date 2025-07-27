import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeText extends StatelessWidget {
  const HomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 115, 0, 255), // Match the text color for consistency
          width: 2, // Adjust border width as needed
        ),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10), // Ensures at least 10px offset on all sides
        child: RichText(
          text: TextSpan(
            text: 'our ',
            style: GoogleFonts.raleway(
              fontSize: 14,
              color: Color.fromARGB(255, 115, 0, 255),
              fontWeight: FontWeight.w700,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'recommendations based on',
                style: GoogleFonts.raleway(
                  fontSize: 14,
                  color: const Color.fromARGB(255, 115, 0, 255),
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: ' your:',
                style: GoogleFonts.raleway(
                  fontSize: 14,
                  color: Color.fromARGB(255, 115, 0, 255),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataTextModel extends StatelessWidget {
  DataTextModel({
    super.key,
    required this.text,
    this.data,
    required this.colorTitle,
    this.isStroke,
  });
  final text;
  String? data;
  bool? isStroke;
  Color colorTitle;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),

        children: [
          isStroke == null || isStroke == false
              ? TextSpan(
                text: data != null ? text + '\n' : text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: colorTitle,
                  fontWeight: FontWeight.w600,
                ),
              )
              : TextSpan(
                text: data != null ? text + '\n' : text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  foreground:
                      Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = colorTitle,
                ),
              ),
          TextSpan(text: data == ' ' || data == '' ? 'Not found' : data),
        ],
      ),
    );
  }
}

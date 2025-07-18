import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/model/university.dart';

class AcademicsTab extends StatelessWidget {
  AcademicsTab({super.key, required this.university});
  University university;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bachelor resume',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 5),
                Text(
                  university.duration == null ? ' ' : university.duration!,

                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.attach_money, size: 16),
                const SizedBox(width: 5),
                Text(
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                  university.money == null ? ' ' : university.money!,

                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.language, size: 16),
                const SizedBox(width: 5),
                Text(
                  university.language == null ? ' ' : university.language!,

                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 10),

            const SizedBox(height: 40),
            Text(
              university.data == null ? ' ' : university.data!,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

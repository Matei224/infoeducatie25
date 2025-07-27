import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/model/dataTextModel.dart';
import 'package:studee_app/model/university.dart';
import 'package:studee_app/model/university/univeristy_full.dart';
import 'package:studee_app/model/url_link.dart';

class AcademicsTab extends StatelessWidget {
  AcademicsTab({super.key, required this.university});
  ActualUniveristy university;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details about the admissions process and requirements.',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                const Icon(Icons.school, size: 16),
                const SizedBox(width: 5),
                Expanded(
                  child: DataTextModel(
                    text: 'Graduation rate:',
                    data: university.graduationRate,
                    colorTitle: Color.fromARGB(255, 115, 0, 255),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.work, size: 16),
                const SizedBox(width: 5),
                Expanded(
                  child: DataTextModel(
                    text: 'Employabillity rate:',
                    data: university.employabilityRate,
                    colorTitle: Color.fromARGB(255, 115, 0, 255),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.group, size: 16),
                const SizedBox(width: 5),
                Expanded(
                  child: DataTextModel(
                    text: 'Retention rate:',
                    data: university.retentionRate,
                    colorTitle: Color.fromARGB(255, 115, 0, 255),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.emoji_events, size: 16),
                const SizedBox(width: 5),
                Expanded(
                  child: DataTextModel(
                    text: 'Rank:',
                    data: university.rank,
                    colorTitle: Color.fromARGB(255, 115, 0, 255),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.local_activity, size: 16),
                const SizedBox(width: 5),
                Expanded(
                  child: DataTextModel(
                    text: 'Extracurricular clubs:',
                    data: university.extracurricularClubs,
                    colorTitle: Color.fromARGB(255, 115, 0, 255),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.library_books, size: 16),
                const SizedBox(width: 5),
                Expanded(
                  child: DataTextModel(
                    text: 'Undergraduate Programmes:',
                    data: university.undergraduateProgrammes,
                    colorTitle: Color.fromARGB(255, 115, 0, 255),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.description, size: 16),
                const SizedBox(width: 5),
                Expanded(
                  child: DataTextModel(
                    text: 'Academics description:',
                    data: university.academicsDescription,
                    colorTitle: Color.fromARGB(255, 115, 0, 255),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.public, size: 16),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DataTextModel(
                        text: 'Home page url:',
                        colorTitle: Color.fromARGB(255, 115, 0, 255),
                      ),
                      !(university.homePageUrl == null ||
                              university.homePageUrl == '')
                          ? UrlLink(text: university.homePageUrl)
                          : Text(''),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DataTextModel(
                        text: 'Academics maps location url:',
                        colorTitle: Color.fromARGB(255, 115, 0, 255),
                      ),
                      !(university.academicsMapsLocationUrl == null ||
                              university.academicsMapsLocationUrl == '')
                          ? UrlLink(text: university.academicsMapsLocationUrl)
                          : Text(''),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

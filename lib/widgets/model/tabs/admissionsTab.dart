import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/widgets/model/dataTextModel.dart';
import 'package:studee_app/data/university/univeristy_full.dart';
import 'package:studee_app/widgets/model/url_link.dart';

class AdmissionsTab extends StatelessWidget {
  AdmissionsTab({super.key, required this.university});
  final ActualUniveristy university;

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
               style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),textAlign: TextAlign.justify
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.pie_chart),
                SizedBox(width: 10),
                Expanded(
                  child:  DataTextModel(text: 'Acceptance rate:', data: university.acceptanceRate,colorTitle:  Color.fromARGB(255, 255, 81, 0),),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.language),
                SizedBox(width: 10),
                Expanded(
                  child:  DataTextModel(text: 'English requirements:', data: university.englishRequirements,colorTitle:  Color.fromARGB(255, 255, 81, 0))
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.language),
                SizedBox(width: 10),
                Expanded(
                  child:  DataTextModel(text: 'Other languages:', data: university.otherLanguages,colorTitle:  Color.fromARGB(255, 255, 81, 0))
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.assignment),
                SizedBox(width: 10),
                Expanded(
                  child: DataTextModel(text: 'Exam based:', data: university.examBased,colorTitle:  Color.fromARGB(255, 255, 81, 0))
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.folder),
                SizedBox(width: 10),
                Expanded(
                  child:  DataTextModel(text: 'Portfolio based:', data: university.portfolioBased,colorTitle:  Color.fromARGB(255, 255, 81, 0))
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.school),
                SizedBox(width: 10),
                Expanded(
                  child: DataTextModel(text: 'Which bac is needed:', data: university.bacNeeded,colorTitle:  Color.fromARGB(255, 255, 81, 0))
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.grade),
                SizedBox(width: 10),
                Expanded(
                  child: DataTextModel(text: 'Average entry GPA:', data: university.averageGpaEntry,colorTitle:  Color.fromARGB(255, 255, 81, 0))
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.people),
                SizedBox(width: 10),
                Expanded(
                  child:  DataTextModel(text: 'Average applicants number:', data: university.averageApplicantsNumber,colorTitle:  Color.fromARGB(255, 255, 81, 0))
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 10),
                Expanded(
                  child:  DataTextModel(text: 'Admission dates for next year:', data: university.admissionDates,colorTitle:  Color.fromARGB(255, 255, 81, 0))
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.info),
                SizedBox(width: 10),
                Expanded(
                  child:  DataTextModel(text: 'Description of admissions:', data: university.admissionsDescription,colorTitle:  Color.fromARGB(255, 255, 81, 0))
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.web),
                SizedBox(width: 10),
                Expanded(
                  child: Column(      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DataTextModel(text: 'Admissions page url',colorTitle:  Color.fromARGB(255, 255, 81, 0)),    !(university.admissionsPageUrl == null ||
                            university.admissionsPageUrl == '') ?
                            UrlLink(text: university.admissionsPageUrl ) : Text('')
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.map),
                SizedBox(width: 10),
                Expanded(
                  child: Column(      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       DataTextModel(text: 'Maps location url:',colorTitle:  Color.fromARGB(255, 255, 81, 0)),
                        !(university.admissionsMapsLocationUrl == null ||
                            university.admissionsMapsLocationUrl == '') ?
                            UrlLink(text: university.admissionsMapsLocationUrl ) : Text('')
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

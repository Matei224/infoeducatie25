import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/model/dataTextModel.dart';
import 'package:studee_app/model/university/univeristy_full.dart';
import 'package:studee_app/model/url_link.dart';

class CampusTab extends StatelessWidget {
  CampusTab({super.key, required this.university});
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
              'Information about the university campus, including safety, costs, and resources.',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),textAlign: TextAlign.justify
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.security),
                SizedBox(width: 10),
                Expanded(
                  child: DataTextModel(text: 'Safety rate:', data: university.safetyRate,colorTitle: Color.fromARGB(255, 255, 132, 177),),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.group),
                SizedBox(width: 10),
                Expanded(
                  child: DataTextModel(text: 'Average students in campus:', data: university.averageStudentsNumber,colorTitle: Color.fromARGB(255, 255, 132, 177)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.attach_money),
                SizedBox(width: 10),
                Expanded(
                  child: DataTextModel(text: 'Average cost per year campus:', data: university.costPerYear,colorTitle: Color.fromARGB(255, 255, 132, 177))
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.info),
                SizedBox(width: 10),
                Expanded(
                  child: DataTextModel(text: 'Campus description:', data: university.campusDescription,colorTitle: Color.fromARGB(255, 255, 132, 177))
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
                       DataTextModel(text: 'Campus page url:',colorTitle: Color.fromARGB(255, 255, 132, 177)),
                        !(university.campusMapsLocationUrl == null ||
                            university.campusMapsLocationUrl == '') ?
                            UrlLink(text: university.campusMapsLocationUrl ) : Text('')
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
                      DataTextModel(text: 'Graduation rate:',colorTitle: Color.fromARGB(255, 255, 132, 177)),
                       !(university.campusMapsLocationUrl == null ||
                            university.campusMapsLocationUrl == '') ?
                            UrlLink(text: university.campusMapsLocationUrl ) : Text('')
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.warning),
                SizedBox(width: 10),
                Expanded(
                  child: Column(      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                                           DataTextModel(text: 'Link to numbeo crime url:',colorTitle: Color.fromARGB(255, 255, 132, 177)),
    !(university.numbeoCrimeUrl == null ||
                            university.numbeoCrimeUrl == '') ?
                            UrlLink(text: university.numbeoCrimeUrl ) : Text('')
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.shield),
                SizedBox(width: 10),
                Expanded(
                  child: Column(      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                                                               DataTextModel(text: 'Link to numbeo safety url:',colorTitle: Color.fromARGB(255, 255, 132, 177)),

                        !(university.numbeoSafetyUrl == null ||
                            university.numbeoSafetyUrl == '') ?
                            UrlLink(text: university.numbeoSafetyUrl ) : Text('')
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

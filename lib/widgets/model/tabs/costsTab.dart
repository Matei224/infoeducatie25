import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/widgets/model/dataTextModel.dart';
import 'package:studee_app/data/university/univeristy_full.dart';
import 'package:studee_app/widgets/model/url_link.dart';

class CostsTab extends StatelessWidget {
  CostsTab({super.key, required this.university});
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
              'Information about the application process, requirements, and deadlines will be here.',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20), 
            Row(
              children: [
                Icon(Icons.attach_money),
                SizedBox(width: 10),
                Expanded(
                  child: DataTextModel(
                    text: 'Average cost per year:',
                    data: university.averageCostPerYear,
                    isStroke: true,
                    colorTitle: Color.fromARGB(255, 200, 255, 0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Icon(Icons.school),
                SizedBox(width: 10),
                Expanded(
                  child: DataTextModel(
                    text: 'Students receiving Financial Aid:',
                    data: university.studentsReceivingFinancialAidPercentage,  isStroke: true,
                    colorTitle: Color.fromARGB(255, 200, 255, 0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 10),
                Expanded(
                  child: DataTextModel(
                    text: 'Financial Aid Application Date:',
                    data: university.financialAidApplicationDate,  isStroke: true,
                    colorTitle: Color.fromARGB(255, 200, 255, 0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Icon(Icons.home),
                SizedBox(width: 10),
                Expanded(
                  child: DataTextModel(
                    text: 'Housing found rate by Students:',  isStroke: true,
                    colorTitle: Color.fromARGB(255, 200, 255, 0),
                    data: university.housingFoundRate,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Icon(Icons.monetization_on),
                SizedBox(width: 10),
                Expanded(
                  child: DataTextModel(
                    text: 'Housing price per year:',
                    data: university.housingPricePerYear,  isStroke: true,
                    colorTitle: Color.fromARGB(255, 200, 255, 0),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Icon(Icons.account_balance),
                SizedBox(width: 10),
                Expanded(
                  child: DataTextModel(
                    text: 'Taxes cost per year:',
                    data: university.taxesCostPerYear,  isStroke: true,
                    colorTitle: Color.fromARGB(255, 200, 255, 0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Icon(Icons.book),
                SizedBox(width: 10),
                Expanded(
                  child: DataTextModel(
                    text: 'Supplies cost per year:',
                    data: university.suppliesCostPerYear,  isStroke: true,
                    colorTitle: Color.fromARGB(255, 200, 255, 0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Icon(Icons.info),
                SizedBox(width: 10),
                Expanded(
                  child: DataTextModel(
                    text: 'Description of life in the city of university:',  isStroke: true,
                    colorTitle: Color.fromARGB(255, 200, 255, 0),
                    data: university.lifeDescription,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Icon(Icons.web),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DataTextModel(text: 'Costs page url:',  isStroke: true,
                    colorTitle: Color.fromARGB(255, 200, 255, 0),),

                      !(university.costsPageUrl == null ||
                              university.costsPageUrl == '')
                          ? UrlLink(text: university.costsPageUrl)
                          : Text(''),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DataTextModel(text: 'Maps location link:',  isStroke: true,
                    colorTitle: Color.fromARGB(255, 200, 255, 0),),

                      !(university.lifeMapsLocationUrl == null ||
                              university.lifeMapsLocationUrl == '')
                          ? UrlLink(text: university.lifeMapsLocationUrl)
                          : Text(''),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Icon(Icons.house),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DataTextModel(
                        text: 'Link to numbeo for property prices:',  isStroke: true,
                    colorTitle: Color.fromARGB(255, 200, 255, 0),
                      ),

                      !(university.numbeoPropertyPricesUrl == null ||
                              university.numbeoPropertyPricesUrl == '')
                          ? UrlLink(text: university.numbeoPropertyPricesUrl)
                          : Text(''),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Icon(Icons.shopping_cart),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DataTextModel(
                        text: 'Link to numbeo for Good and Services prices:',  isStroke: true,
                    colorTitle: Color.fromARGB(255, 200, 255, 0),
                      ),
                      !(university.numbeoGoodsAndServicesPricesUrl == null ||
                              university.numbeoGoodsAndServicesPricesUrl == '')
                          ? UrlLink(
                            text: university.numbeoGoodsAndServicesPricesUrl,
                          )
                          : Text(''),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Icon(Icons.restaurant),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DataTextModel(text: 'Link to numbeo for food prices:',  isStroke: true,
                    colorTitle: Color.fromARGB(255, 200, 255, 0),),

                      !(university.numbeoFoodPricesUrl == null ||
                              university.numbeoFoodPricesUrl == '')
                          ? UrlLink(text: university.numbeoFoodPricesUrl)
                          : Text(''),
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

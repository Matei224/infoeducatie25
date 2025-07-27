import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:studee_app/model/university_data.dart';
import 'dart:async';

import 'package:studee_app/services/api_services.dart';

// API key for OpenRouter
final apiKey =
    'not';
Future<String> getOpenRouterResponse(String userInput) async {
  const endpoint = 'https://openrouter.ai/api/v1/chat/completions';

  final headers = {
    'Authorization': 'Bearer $apiKey',
    'Content-type': 'application/json',
  };

  final body = jsonEncode({
    'model': 'deepseek/deepseek-chat-v3-0324:free',
    'prompt': userInput,
    'max_tokens': 2000,
    'temperature': 0.7,
  });

  final response = await http.post(
    Uri.parse(endpoint),
    headers: headers,
    body: body,
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['choices'][0]['text'];
  } else {
    throw Exception('Failed to get repsonse : ${response.body}');
  }
}

// Questionnaire template
const String questionnaire = '''
**Academics category**
-Graduation rate:
-Employabillity rate:
-Retention Rate:
-Rank:
-Extracurricular Clubs enumerate:
-Undergraduate programmes available number and list:
-Description of Academics (make it longer):
-Home page university website:
-maps location link:

**Costs category**
-Average cost per Year:
-Students Receiving Financial Aid percentage:
-Opened Financial Aid Application date:

**Life category**
-Housing Found Rate by students:
-Housing price per year:
-Taxes cost per year:
-Supplies cost per year:
-Description of life in the city of university (make it longer):
-Costs page university website:
-maps location link:
-Link to numbeo website for that city of university with prices for property:
-Link to numbeo website for that city of university with prices for good and services:
-Link to numbeo website for that city of university with prices for and food prices:

**Admissions category**
-Acceptance Rate:
-English Requirements: Yes/No, exam type minimum
-Other languages: Yes – which – exam type minimum/No
-Exam based: Yes – at which subjects/No
-Portfolio based: Yes/No
-Which BAC is needed:
-Average GPA entry:
-Average applicants number:
-Admission dates for next year: Know – which / Unknown
-Description of admissions (make it longer):
-Admissions page university:
-maps location link:

**Campus category**
-Safety Rate:
-Average students in campus number:
-Cost per year of campus:
-Description (make it longer):
-Campus page university link:
-maps location link:
-Link to numbeo website for that city of university with crime:
-Link to numbeo website for that city of university with safety:
''';

// Fetch response from OpenRouter API

// Main function to update the database
void main() async {
  final databaseFactory = databaseFactoryFfi;

  // Open the database
  final db = await databaseFactory.openDatabase('final_europe_universities.db');
  final newColumns = [
    'graduationRate',
    'employabilityRate',
    'retentionRate',
    'rank',
    'extracurricularClubs',
    'undergraduateProgrammesCount',
    'undergraduateProgrammes',
    'academicsDescription',
    'homePageUrl',
    'academicsMapsLocationUrl',
    'averageCostPerYear',
    'studentsReceivingFinancialAidPercentage',
    'financialAidApplicationDate',
    'housingFoundRate',
    'housingPricePerYear',
    'taxesCostPerYear',
    'suppliesCostPerYear',
    'lifeDescription',
    'costsPageUrl',
    'lifeMapsLocationUrl',
    'numbeoPropertyPricesUrl',
    'numbeoGoodsAndServicesPricesUrl',
    'numbeoFoodPricesUrl',
    'acceptanceRate',
    'englishRequirements',
    'otherLanguages',
    'examBased',
    'portfolioBased',
    'bacNeeded',
    'averageGpaEntry',
    'averageApplicantsNumber',
    'admissionDates',
    'admissionsDescription',
    'admissionsPageUrl',
    'admissionsMapsLocationUrl',
    'safetyRate',
    'averageStudentsNumber',
    'costPerYear',
    'campusDescription',
    'campusPageUrl',
    'campusMapsLocationUrl',
    'numbeoCrimeUrl',
    'numbeoSafetyUrl',
  ];

  final tableInfo = await db.rawQuery('PRAGMA table_info(universities)');
  final existingColumns =
      tableInfo.map((info) => info['name'] as String).toSet();

  for (var column in newColumns) {
    if (!existingColumns.contains(column)) {
      await db.execute('ALTER TABLE universities ADD COLUMN $column TEXT');
      print('Added column: $column');
    }
  }
  final universities = await db.query(
    'universities',
    columns: ['id', 'name', 'webPages'],
  );
  var i = 0;
  for (var university in universities) {
    try {
      final id = university['id'] as int;
      final name = university['name'] as String;
      final webPagesJson = university['webPages'] as String;
      final webPages = jsonDecode(webPagesJson) as List<dynamic>;
      final website =
          webPages.isNotEmpty ? webPages[0] as String : 'https://example.com';

      final prompt =
          '''Search on $website and other websites relevant to $name and 
      complete this questionnaire in English only with the actual data required after ':' ; $questionnaire''';

      final response = await getOpenRouterResponse(prompt);
      var data = parseData1(response);
      print(response);
      if (data.isEmpty || data == null) data = parseData2(response);
      final academics = createAcademics(data["Academics category"] ?? {});
      final costs = createCosts(data["Costs category"] ?? {});
      final life = createLife(data["Life category"] ?? {});
      final admissions = createAdmissions(data["Admissions category"] ?? {});
      final campus = createCampus(data["Campus category"] ?? {});
      final updateValues = {
        'graduationRate': academics.graduationRate,
        'employabilityRate': academics.employabilityRate,
        'retentionRate': academics.retentionRate,
        'rank': academics.rank,
        'extracurricularClubs': academics.extracurricularClubs,
        'undergraduateProgrammesCount': academics.undergraduateProgrammesCount,
        'undergraduateProgrammes': academics.undergraduateProgrammes,
        'academicsDescription': academics.description,
        'homePageUrl': academics.homePageUrl,
        'academicsMapsLocationUrl': academics.mapsLocationUrl,
        'averageCostPerYear': costs.averageCostPerYear,
        'studentsReceivingFinancialAidPercentage':
            costs.studentsReceivingFinancialAidPercentage,
        'financialAidApplicationDate': costs.financialAidApplicationDate,
        'housingFoundRate': life.housingFoundRate,
        'housingPricePerYear': life.housingPricePerYear,
        'taxesCostPerYear': life.taxesCostPerYear,
        'suppliesCostPerYear': life.suppliesCostPerYear,
        'lifeDescription': life.description,
        'costsPageUrl': life.costsPageUrl,
        'lifeMapsLocationUrl': life.mapsLocationUrl,
        'numbeoPropertyPricesUrl': life.numbeoPropertyPricesUrl,
        'numbeoGoodsAndServicesPricesUrl': life.numbeoGoodsAndServicesPricesUrl,
        'numbeoFoodPricesUrl': life.numbeoFoodPricesUrl,
        'acceptanceRate': admissions.acceptanceRate,
        'englishRequirements': admissions.englishRequirements,
        'otherLanguages': admissions.otherLanguages,
        'examBased': admissions.examBased,
        'portfolioBased': admissions.portfolioBased,
        'bacNeeded': admissions.bacNeeded,
        'averageGpaEntry': admissions.averageGpaEntry,
        'averageApplicantsNumber': admissions.averageApplicantsNumber,
        'admissionDates': admissions.admissionDates,
        'admissionsDescription': admissions.description,
        'admissionsPageUrl': admissions.admissionsPageUrl,
        'admissionsMapsLocationUrl': admissions.mapsLocationUrl,
        'safetyRate': campus.safetyRate,
        'averageStudentsNumber': campus.averageStudentsNumber,
        'costPerYear': campus.costPerYear,
        'campusDescription': campus.description,
        'campusPageUrl': campus.campusPageUrl,
        'campusMapsLocationUrl': campus.mapsLocationUrl,
        'numbeoCrimeUrl': campus.numbeoCrimeUrl,
        'numbeoSafetyUrl': campus.numbeoSafetyUrl,
      };
      print(updateValues);

      // Update the database
      await db.update(
        'universities',
        updateValues,
        where: 'id = ?',
        whereArgs: [id],
      );

      print('Updated $name successfully');
    } catch (e) {
      print('Error updating ${university['name']}: $e');
    }

    // Delay to respect API rate limits
    await Future.delayed(Duration(seconds: 5));
  }

  // Close the database
  await db.close();
  print('Database update completed.');
}

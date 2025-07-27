import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:convert';

void main() async {
  // Initialize sqflite for desktop
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;

  // Open the new database
  final newDb = await databaseFactory.openDatabase('final_europe_universities.db');

  // Create the universities table with original and new columns
  await newDb.execute('''
    CREATE TABLE universities (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      city TEXT NOT NULL,
      country TEXT NOT NULL,
      urlImage TEXT NOT NULL,
      urlLogo TEXT NOT NULL,
      degree TEXT NOT NULL,
      programme TEXT NOT NULL,
      fullName TEXT NOT NULL,
      duration TEXT NOT NULL,
      money TEXT NOT NULL,
      language TEXT NOT NULL,
      data TEXT NOT NULL,
      webPages TEXT,
      alphaTwoCode TEXT NOT NULL,
      -- Academics
      graduationRate TEXT,
      employabilityRate TEXT,
      retentionRate TEXT,
      rank TEXT,
      extracurricularClubs TEXT,
      undergraduateProgrammesCount TEXT,
      undergraduateProgrammes TEXT,
      academicsDescription TEXT,
      homePageUrl TEXT,
      academicsMapsLocationUrl TEXT,
      -- Costs
      averageCostPerYear TEXT,
      studentsReceivingFinancialAidPercentage TEXT,
      financialAidApplicationDate TEXT,
      -- Life
      housingFoundRate TEXT,
      housingPricePerYear TEXT,
      taxesCostPerYear TEXT,
      suppliesCostPerYear TEXT,
      lifeDescription TEXT,
      costsPageUrl TEXT,
      lifeMapsLocationUrl TEXT,
      numbeoPropertyPricesUrl TEXT,
      numbeoGoodsAndServicesPricesUrl TEXT,
      numbeoFoodPricesUrl TEXT,
      -- Admissions
      acceptanceRate TEXT,
      englishRequirements TEXT,
      otherLanguages TEXT,
      examBased TEXT,
      portfolioBased TEXT,
      bacNeeded TEXT,
      averageGpaEntry TEXT,
      averageApplicantsNumber TEXT,
      admissionDates TEXT,
      admissionsDescription TEXT,
      admissionsPageUrl TEXT,
      admissionsMapsLocationUrl TEXT,
      -- Campus
      safetyRate TEXT,
      averageStudentsNumber TEXT,
      costPerYear TEXT,
      campusDescription TEXT,
      campusPageUrl TEXT,
      campusMapsLocationUrl TEXT,
      numbeoCrimeUrl TEXT,
      numbeoSafetyUrl TEXT
    )
  ''');

  // Open the original database
  final originalDb = await databaseFactory.openDatabase('europe_universities.db');

  // Fetch all rows from the original universities table
  final rows = await originalDb.query('universities');

  // Insert each row into the new database, adding new columns with ''
  for (var row in rows) {
    await newDb.insert('universities', {
      'id': row['id'], // Preserve the original id
      'name': row['name'],
      'city': row['city'],
      'country': row['country'],
      'urlImage': row['urlImage'],
      'urlLogo': row['urlLogo'],
      'degree': row['degree'],
      'programme': row['programme'],
      'fullName': row['fullName'],
      'duration': row['duration'],
      'money': row['money'],
      'language': row['language'],
      'data': row['data'],
      'webPages': row['webPages'],
      'alphaTwoCode': row['alphaTwoCode'],
      // New columns initialized to ''
      'graduationRate': '',
      'employabilityRate': '',
      'retentionRate': '',
      'rank': '',
      'extracurricularClubs': '',
      'undergraduateProgrammesCount': '',
      'undergraduateProgrammes': '',
      'academicsDescription': '',
      'homePageUrl': '',
      'academicsMapsLocationUrl': '',
      'averageCostPerYear': '',
      'studentsReceivingFinancialAidPercentage': '',
      'financialAidApplicationDate': '',
      'housingFoundRate': '',
      'housingPricePerYear': '',
      'taxesCostPerYear': '',
      'suppliesCostPerYear': '',
      'lifeDescription': '',
      'costsPageUrl': '',
      'lifeMapsLocationUrl': '',
      'numbeoPropertyPricesUrl': '',
      'numbeoGoodsAndServicesPricesUrl': '',
      'numbeoFoodPricesUrl': '',
      'acceptanceRate': '',
      'englishRequirements': '',
      'otherLanguages': '',
      'examBased': '',
      'portfolioBased': '',
      'bacNeeded': '',
      'averageGpaEntry': '',
      'averageApplicantsNumber': '',
      'admissionDates': '',
      'admissionsDescription': '',
      'admissionsPageUrl': '',
      'admissionsMapsLocationUrl': '',
      'safetyRate': '',
      'averageStudentsNumber': '',
      'costPerYear': '',
      'campusDescription': '',
      'campusPageUrl': '',
      'campusMapsLocationUrl': '',
      'numbeoCrimeUrl': '',
      'numbeoSafetyUrl': '',
    });
  }

  // Close both databases
  await originalDb.close();
  await newDb.close();

  print('New database generated at filtered_universities.db with ${rows.length} universities.');
}
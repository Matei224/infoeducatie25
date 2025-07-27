import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  // Initialize sqflite for desktop
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;

  // Open the existing database
  final existingDb = await databaseFactory.openDatabase('filtered_universities.db');

  // Query universities where urlImage starts with 'h', limited to 1000
 final universities = await existingDb.query(
    'universities',
    where: 'graduationRate IS NOT NULL AND GraduationRate <> ?',
    whereArgs: [''], // Represents "not empty"
  );


  // Open the new database
  final newDb = await databaseFactory.openDatabase('actual_universities.db');

  // Create the universities table in the new database
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

  // Insert the selected universities into the new database using a batch
  final batch = newDb.batch();
  for (var university in universities) {
    final Map<String, dynamic> newUniversity = Map.from(university);
    newUniversity.remove('id'); // Remove 'id' to allow autoincrement in new db
    batch.insert('universities', newUniversity);
  }
  await batch.commit(noResult: true);

  // Close both databases
  await existingDb.close();
  await newDb.close();

  print('Filtered database generated at filtered_universities.db');
}
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  // Initialize sqflite for desktop
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;

  // List of European country codes (ISO 3166-1 alpha-2)
  const europeanCodes = [
    'AL', 'AD', 'AT', 'BY', 'BE', 'BA', 'BG', 'HR', 'CY', 'CZ',
    'DK', 'EE', 'FI', 'FR', 'DE', 'GR', 'HU', 'IS', 'IE', 'IT',
    'XK', 'LV', 'LI', 'LT', 'LU', 'MT', 'MD', 'MC', 'ME', 'NL',
    'MK', 'NO', 'PL', 'PT', 'RO', 'RU', 'SM', 'RS', 'SK', 'SI',
    'ES', 'SE', 'CH', 'UA', 'GB', 'VA'
  ];

  // Open the existing database
  final existingDb = await databaseFactory.openDatabase('universities.db');

  // Query universities from Europe, limited to 1000
  final placeholders = europeanCodes.map((_) => '?').join(', ');
  final query = "SELECT * FROM universities WHERE alphaTwoCode IN ($placeholders) LIMIT 1000";
  final List<Map<String, dynamic>> universities = await existingDb.rawQuery(query, europeanCodes);

  // Open the new database
  final newDb = await databaseFactory.openDatabase('europe_universities.db');

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
      alphaTwoCode TEXT NOT NULL
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

  print('Filtered database generated at europe_universities.db');
}
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;

  const europeanCodes = [
    'AL', 'AD', 'AT', 'BY', 'BE', 'BA', 'BG', 'HR', 'CY', 'CZ',
    'DK', 'EE', 'FI', 'FR', 'DE', 'GR', 'HU', 'IS', 'IE', 'IT',
    'XK', 'LV', 'LI', 'LT', 'LU', 'MT', 'MD', 'MC', 'ME', 'NL',
    'MK', 'NO', 'PL', 'PT', 'RO', 'RU', 'SM', 'RS', 'SK', 'SI',
    'ES', 'SE', 'CH', 'UA', 'GB', 'VA'
  ];

  final existingDb = await databaseFactory.openDatabase('universities.db');

  final placeholders = europeanCodes.map((_) => '?').join(', ');
  final query = "SELECT * FROM universities WHERE alphaTwoCode IN ($placeholders) LIMIT 1000";
  final List<Map<String, dynamic>> universities = await existingDb.rawQuery(query, europeanCodes);

  final newDb = await databaseFactory.openDatabase('europe_universities.db');

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

  final batch = newDb.batch();
  for (var university in universities) {
    final Map<String, dynamic> newUniversity = Map.from(university);
    newUniversity.remove('id'); 
    batch.insert('universities', newUniversity);
  }
  await batch.commit(noResult: true);

  await existingDb.close();
  await newDb.close();

  print('Filtered database generated at europe_universities.db');
}
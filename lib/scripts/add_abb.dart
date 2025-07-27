import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  // Initialize sqflite for desktop use
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;

  // Open the database
  final db = await databaseFactory.openDatabase('actual_universities.db');

  // Check if the "abreviation" column already exists to avoid errors
  final columns = await db.rawQuery('PRAGMA table_info(universities)');
  bool hasAbreviation = columns.any((column) => column['name'] == 'abreviation');

  // Add the "abreviation" column if it doesn't exist
  if (!hasAbreviation) {
    await db.execute('ALTER TABLE universities ADD COLUMN abreviation TEXT');
  }

  // Query all universities to get their id and name
  final universities = await db.query('universities', columns: ['id', 'name']);

  // Function to generate abbreviation from university name
  String generateAbbreviation(String name) {
    List<String> words = name.split(' ');
    String abbreviation = '';
    for (String word in words) {
      if (word.isNotEmpty && word[0] == word[0].toUpperCase()) {
        abbreviation += word[0];
      }
    }
    return abbreviation;
  }

  // Use a batch to efficiently update all rows
  final batch = db.batch();
  for (var university in universities) {
    String name = university['name'] as String;
    String abbreviation = generateAbbreviation(name);
    batch.update(
      'universities',
      {'abreviation': abbreviation},
      where: 'id = ?',
      whereArgs: [university['id']],
    );
  }
  await batch.commit(noResult: true);

  // Close the database
  await db.close();
  print('Abbreviation column added and updated successfully.');
}
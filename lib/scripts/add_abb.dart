import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;

  final db = await databaseFactory.openDatabase('actual_universities.db');

  final columns = await db.rawQuery('PRAGMA table_info(universities)');
  bool hasAbreviation = columns.any((column) => column['name'] == 'abreviation');

  if (!hasAbreviation) {
    await db.execute('ALTER TABLE universities ADD COLUMN abreviation TEXT');
  }

  final universities = await db.query('universities', columns: ['id', 'name']);

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

  await db.close();
  print('Abbreviation column added and updated successfully.');
}
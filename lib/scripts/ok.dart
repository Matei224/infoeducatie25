import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:studee_app/data/database.dart';
import 'dart:convert';
import 'package:studee_app/model/university.dart'; 
import 'package:studee_app/services/api_services.dart'; 

void main() async {
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;

  final db = await databaseFactory.openDatabase('universities.db');

  await db.execute('''
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

  final apiServices = ApiServices();
  final universities = await apiServices.getUniversities();
  if (universities != null && universities.isNotEmpty) {
    for (var university in universities) {
      final imageData = await apiServices.getUniversityImage(university.name);
      await db.insert('universities', {
        'name': university.name,
        'city': university.city,
        'country': university.country,
        'urlImage': imageData?['imageUrl'] ?? '',
        'urlLogo': imageData?['logoUrl'] ?? '',
        'degree': university.degree,
        'programme': university.programme,
        'fullName': university.fullName,
        'duration': university.duration,
        'money': university.money,
        'language': university.language,
        'data': university.data,
        'webPages': jsonEncode(university.webPages),
        'alphaTwoCode': university.alphaTwoCode,
      });
    }
    print('Inserted ${universities.length} universities into the database.');
  } else {
    print('No universities fetched from the API.');
  }

  await db.close();
  print('Database generated at universities.db');
}
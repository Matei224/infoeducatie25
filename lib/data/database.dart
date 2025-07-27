import 'dart:io';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:studee_app/model/filterchipitem.dart';
import 'package:studee_app/model/university/univeristy_full.dart';
import 'package:studee_app/services/api_services.dart';
import 'package:studee_app/widgets/filteringrow.dart';
import '../model/university.dart';
import 'package:http/http.dart' as http;

 
  String? test;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  DatabaseHelper._init();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!; 
    String path = join(await getDatabasesPath(), 'actual_universities.db');
if (!await databaseExists(path)) {
      try {
        await Directory(dirname(path)).create(recursive: true);
        ByteData data = await rootBundle.load('assets/actual_universities.db');
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(path).writeAsBytes(bytes, flush: true);
        print('Database copied from assets to $path');
      } catch (e) {
        print('Error copying database: $e');
      }
    }

    _database = await openDatabase(path, version: 1);
    return _database!;
  }
Future<void> deleteDatabaseFile() async {
  String path = join(await getDatabasesPath(), 'actual_universities.db');
  await deleteDatabase(path);
}





  Future<List<ActualUniveristy>> getUniversities() async {
  Database db = await database;
  List<Map<String, dynamic>> maps = await db.query('universities');
  return List.generate(maps.length, (i) => ActualUniveristy.fromMap(maps[i]));
}

  Future<List<University>> getFilteredUniversities(
    String searchQuery,
    Map<Filter, String> filters,
  ) async {
    Database db = await database;
    List<String> whereClauses = [];
    List<String> whereArgs = [];

    if (searchQuery.isNotEmpty) {
      whereClauses.add("LOWER(name) LIKE '%' || LOWER(?) || '%'");
      whereArgs.add(searchQuery);
    }

   if (filters[Filter.programme]?.isNotEmpty ?? false) {
  whereClauses.add(
    "(undergraduateProgrammes IS NOT NULL AND LOWER(undergraduateProgrammes) LIKE '%' || LOWER(?) || '%')",
  );
  whereArgs.add(filters[Filter.programme]!);
}

    if (filters[Filter.location]?.isNotEmpty ?? false) {
      whereClauses.add("(country IS NOT NULL AND LOWER(country) = LOWER(?))");
      whereArgs.add(filters[Filter.location]!);
    }

    if (filters[Filter.degree]?.isNotEmpty ?? false) {
      whereClauses.add("(degree IS NOT NULL AND LOWER(degree) = LOWER(?))");
      whereArgs.add(filters[Filter.degree]!);
    }

    String whereString =
        whereClauses.isNotEmpty ? whereClauses.join(' AND ') : '';

    List<Map<String, dynamic>> maps;
    if (whereClauses.isNotEmpty) {
      maps = await db.query(
        'universities',
        where: whereString,
        whereArgs: whereArgs,
      );
    } else {
      maps = await db.query('universities');
    }

    return List.generate(maps.length, (i) {
      return University.fromMap(maps[i]);
    });
  }

  Future<List<University>> getSimilarUniversities(String prefix) async {
  final db = await database;
  final maps = await db.query(
    'universities',
    where: 'name LIKE ? COLLATE NOCASE',
    whereArgs: ['$prefix%'],
  );
  return maps.map((map) => University.fromMap(map)).toList();
}

  Future<void> insertInitialData(List<University> universities) async {
    Database db = await database;
    Batch batch = db.batch();
    for (var university in universities) {
      batch.insert('universities', university.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<List<ActualUniveristy>> searchUniversities(
    String query,
    Map<Filter, String> filters,
  ) async {
    final db = await database;
    String whereClause =
        '(name LIKE ? COLLATE NOCASE OR (abreviation == ? COLLATE NOCASE))'; // Case-insensitive name search
    List<String> whereArgs = ['%$query%','%$query%']; // Wildcards for partial matching

    // Add programme filter if set
    if (filters[Filter.programme] != '') {
      whereClause += " AND (undergraduateProgrammes IS NOT NULL AND LOWER(undergraduateProgrammes) LIKE '%' || LOWER(?) || '%')";
      whereArgs.add(filters[Filter.programme]!);
    }

    // Add degree filter if set
    if (filters[Filter.degree] != '') {
      if (filters[Filter.degree]?.isNotEmpty ?? false) {
  final budgetFilterValue = filters[Filter.degree]!;
  if (budgetFilterValue == 'Free') {
    whereClause += " AND ((LOWER(averageCostPerYear) LIKE '%' || LOWER('No') || '%') OR (LOWER(averageCostPerYear) LIKE '%' || LOWER('€0') || '%') OR (LOWER(averageCostPerYear) LIKE '%' || LOWER('Free') || '%'))";
  } else if (budgetFilterValue == 'Priced') {
    whereClause += " AND ((LOWER(averageCostPerYear) NOT LIKE '%' || LOWER('No') || '%') AND (LOWER(averageCostPerYear) NOT LIKE '%' || LOWER('€0') || '%') AND (LOWER(averageCostPerYear) NOT LIKE '%' || LOWER('Free') || '%'))";
  }
}
    }

    // Add location (country) filter if set
    if (filters[Filter.location] != '') {
      whereClause += " AND country = ? COLLATE NOCASE";
      whereArgs.add(filters[Filter.location]!);
      print(filters[Filter.location]);
    }

    final maps = await db.query(
      'universities', // Table name
      where: whereClause,
      whereArgs: whereArgs,
    );
    return maps.map((map) => ActualUniveristy.fromMap(map)).toList();

  }
}

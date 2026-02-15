import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/employee_model.dart';

class EmployeeLocalDataSource {
  EmployeeLocalDataSource._();

  static final EmployeeLocalDataSource instance = EmployeeLocalDataSource._();

  static const String _tableName = 'employees';
  static const String _databaseName = 'employees.db';
  static const String _seedAssetPath = 'assets/mock/employees.json';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String dbPath = await getDatabasesPath();

    return openDatabase(
      join(dbPath, _databaseName),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            full_name TEXT NOT NULL,
            job_title TEXT NOT NULL,
            country TEXT NOT NULL,
            salary REAL NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> seedDummyEmployeesIfEmpty() async {
    final Database db = await database;
    final int count = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM $_tableName'),
        ) ??
        0;

    if (count > 0) {
      return;
    }

    final String jsonString = await rootBundle.loadString(_seedAssetPath);
    final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;

    final List<EmployeeModel> dummyEmployees = jsonList
        .map(
          (dynamic item) => EmployeeModel(
            fullName: item['fullName'] as String,
            jobTitle: item['jobTitle'] as String,
            country: item['country'] as String,
            salary: (item['salary'] as num).toDouble(),
          ),
        )
        .toList();

    await db.transaction((Transaction txn) async {
      final Batch batch = txn.batch();
      for (final EmployeeModel employee in dummyEmployees) {
        batch.insert(_tableName, employee.toMap());
      }
      await batch.commit(noResult: true);
    });
  }

  Future<List<EmployeeModel>> fetchEmployees() async {
    final Database db = await database;
    final List<Map<String, Object?>> rows = await db.query(
      _tableName,
      orderBy: 'id DESC',
    );

    return rows.map(EmployeeModel.fromMap).toList();
  }

  Future<EmployeeModel> createEmployee(EmployeeModel employee) async {
    final Database db = await database;
    final int id = await db.insert(_tableName, employee.toMap());

    return EmployeeModel(
      id: id,
      fullName: employee.fullName,
      jobTitle: employee.jobTitle,
      country: employee.country,
      salary: employee.salary,
    );
  }

  Future<void> updateEmployee(EmployeeModel employee) async {
    final Database db = await database;

    await db.update(
      _tableName,
      employee.toMap(),
      where: 'id = ?',
      whereArgs: <Object?>[employee.id],
    );
  }

  Future<void> deleteEmployee(int id) async {
    final Database db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: <Object?>[id],
    );
  }
}

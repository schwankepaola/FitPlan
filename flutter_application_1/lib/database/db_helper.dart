import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    } else {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    _database = await openDatabase(
      'fitplan.db',
      version: 2,

      onCreate: (db, version) async {
        await _criarTabelas(db);
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("DROP TABLE IF EXISTS usuarios");
        await db.execute("DROP TABLE IF EXISTS planos");
        await db.execute("DROP TABLE IF EXISTS historico");

        await _criarTabelas(db);
      },
    );

    return _database!;
  }

  static Future<void> _criarTabelas(Database db) async {
    await db.execute('''
      CREATE TABLE usuarios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        senha TEXT NOT NULL,
        objetivo TEXT,
        idade INTEGER DEFAULT 0,
        peso REAL DEFAULT 0,
        diasSemana INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE planos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        objetivo TEXT,
        dias INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE historico(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        treino TEXT,
        data TEXT
      )
    ''');
  }
}
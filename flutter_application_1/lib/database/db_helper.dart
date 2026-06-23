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
      version: 1,
      onCreate: (db, version) async {
        // 👤 USUÁRIOS
        await db.execute('''
          CREATE TABLE usuarios(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            email TEXT,
            senha TEXT
          )
        ''');

        // 📊 PLANOS
        await db.execute('''
          CREATE TABLE planos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            objetivo TEXT,
            dias INTEGER
          )
        ''');

        // 🏋️ HISTÓRICO (CORRIGIDO)
        await db.execute('''
          CREATE TABLE historico(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            treino TEXT,
            data TEXT
          )
        ''');
      },
    );

    return _database!;
  }
}

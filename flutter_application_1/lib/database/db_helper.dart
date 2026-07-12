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
      version: 3,

      onCreate: (db, version) async {
        // ==========================
        // USUÁRIOS
        // ==========================
        await db.execute('''
        CREATE TABLE usuarios(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          senha TEXT,
          objetivo TEXT,
          idade INTEGER,
          peso REAL,
          diasSemana INTEGER
        )
        ''');

        // ==========================
        // PLANO
        // ==========================
        await db.execute('''
        CREATE TABLE plano(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          usuarioId INTEGER,
          dia TEXT,
          treino TEXT,
          exercicios TEXT,
          concluido INTEGER DEFAULT 0
        )
        ''');

        // ==========================
        // HISTÓRICO
        // ==========================
        await db.execute('''
        CREATE TABLE historico(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          usuarioId INTEGER,
          treino TEXT,
          data TEXT
        )
        ''');

        // ==========================
        // ALERTAS
        // ==========================
        await db.execute('''
        CREATE TABLE alertas(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          titulo TEXT,
          descricao TEXT,
          lido INTEGER DEFAULT 0
        )
        ''');
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("DROP TABLE IF EXISTS usuarios");
        await db.execute("DROP TABLE IF EXISTS plano");
        await db.execute("DROP TABLE IF EXISTS historico");
        await db.execute("DROP TABLE IF EXISTS alertas");

        // ==========================
        // USUÁRIOS
        // ==========================
        await db.execute('''
        CREATE TABLE usuarios(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          senha TEXT,
          objetivo TEXT,
          idade INTEGER,
          peso REAL,
          diasSemana INTEGER
        )
        ''');

        // ==========================
        // PLANO
        // ==========================
        await db.execute('''
        CREATE TABLE plano(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          usuarioId INTEGER,
          dia TEXT,
          treino TEXT,
          exercicios TEXT,
          concluido INTEGER DEFAULT 0
        )
        ''');

        // ==========================
        // HISTÓRICO
        // ==========================
        await db.execute('''
        CREATE TABLE historico(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          usuarioId INTEGER,
          treino TEXT,
          data TEXT
        )
        ''');

        // ==========================
        // ALERTAS
        // ==========================
        await db.execute('''
        CREATE TABLE alertas(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          titulo TEXT,
          descricao TEXT,
          lido INTEGER DEFAULT 0
        )
        ''');
      },
    );

    return _database!;
  }
}
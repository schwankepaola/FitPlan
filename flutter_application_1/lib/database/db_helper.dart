import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'dart:io';
import 'package:path/path.dart';

// Classe responsável por criar e fornecer acesso ao banco de dados da aplicação.
class DatabaseHelper {
  // Mantém uma única instância do banco durante a execução do aplicativo.
  static Database? _database;

  static Future<Database> getDatabase() async {
    // Retorna o banco já aberto, caso exista.
    if (_database != null) return _database!;

    // Configura a fábrica do banco conforme a plataforma utilizada.
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    } else if (Platform.isWindows ||
        Platform.isLinux ||
        Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    // Abre ou cria o banco de dados.
    _database = await openDatabase(
      'fitplan.db',
      version: 3,

      // Executado apenas na primeira criação do banco.
      onCreate: (db, version) async {
        // ==========================
        // Tabela de usuários
        // Armazena as informações de cadastro.
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
        // Tabela de plano de treino
        // Guarda os treinos de cada dia do usuário.
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
        // Tabela de histórico
        // Registra os treinos concluídos.
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
        // Tabela de alertas
        // Armazena as notificações exibidas ao usuário.
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

      // Executado quando a versão do banco é alterada.
      onUpgrade: (db, oldVersion, newVersion) async {
        // Remove as tabelas antigas para recriá-las com a nova estrutura.
        await db.execute("DROP TABLE IF EXISTS usuarios");
        await db.execute("DROP TABLE IF EXISTS plano");
        await db.execute("DROP TABLE IF EXISTS historico");
        await db.execute("DROP TABLE IF EXISTS alertas");

        // ==========================
        // Tabela de usuários
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
        // Tabela de plano
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
        // Tabela de histórico
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
        // Tabela de alertas
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

    // Retorna a instância do banco aberta.
    return _database!;
  }
}
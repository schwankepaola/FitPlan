import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    String path = join(
      await getDatabasesPath(),
      'fitplan.db',
    );

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {

        await db.execute('''
        CREATE TABLE usuarios(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          email TEXT,
          senha TEXT
        )
        ''');

        await db.execute('''
        CREATE TABLE planos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          objetivo TEXT,
          dias INTEGER
        )
        ''');

      },
    );

    return _database!;
  }
}
import 'package:sqflite/sqflite.dart';

import '../database/db_helper.dart';

class AuthService {

  Future<void> cadastrar(
    String nome,
    String email,
    String senha,
  ) async {

    Database db =
        await DatabaseHelper.getDatabase();

    await db.insert(
      'usuarios',
      {
        'nome': nome,
        'email': email,
        'senha': senha,
      },
    );
  }

  Future<bool> login(
    String email,
    String senha,
  ) async {

    Database db =
        await DatabaseHelper.getDatabase();

    List resultado = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [
        email,
        senha,
      ],
    );

    return resultado.isNotEmpty;
  }
}
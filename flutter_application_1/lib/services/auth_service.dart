import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';

class AuthService {
  Future<void> cadastrar(String nome, String senha) async {
    Database db = await DatabaseHelper.getDatabase();

    await db.insert('usuarios', {'nome': nome, 'senha': senha});
  }

  Future<bool> login(String nome, String senha) async {
    print("ABRINDO BANCO...");
    Database db = await DatabaseHelper.getDatabase();
    print("BANCO ABERTO!");

    List resultado = await db.query(
      'usuarios',
      where: 'nome = ? AND senha = ?',
      whereArgs: [nome, senha],
    );

    return resultado.isNotEmpty;
  }
}

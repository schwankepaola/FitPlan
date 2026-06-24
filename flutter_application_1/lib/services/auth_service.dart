import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';

class AuthService {
  static Map<String, dynamic>? usuarioLogado;

  Future<void> cadastrar(String nome, String senha) async {
    Database db = await DatabaseHelper.getDatabase();

    await db.insert(
      'usuarios',
      {
        'nome': nome,
        'senha': senha,
        'email': '',
      },
    );
  }

  Future<bool> login(String nome, String senha) async {
    Database db = await DatabaseHelper.getDatabase();

    List<Map<String, dynamic>> resultado = await db.query(
      'usuarios',
      where: 'nome = ? AND senha = ?',
      whereArgs: [nome, senha],
    );

    if (resultado.isNotEmpty) {
      usuarioLogado = resultado.first;
      return true;
    }

    return false;
  }

  Future<void> salvarDadosUsuario(
    int idade,
    double peso,
  ) async {
    Database db = await DatabaseHelper.getDatabase();

    await db.update(
      'usuarios',
      {
        'idade': idade,
        'peso': peso,
      },
      where: 'id = ?',
      whereArgs: [usuarioLogado!['id']],
    );

    usuarioLogado!['idade'] = idade;
    usuarioLogado!['peso'] = peso;
  }

  static String get nome =>
      usuarioLogado?['nome'] ?? '';

  static int get idade =>
      usuarioLogado?['idade'] ?? 0;

  static double get peso {
    final valor = usuarioLogado?['peso'];

    if (valor == null) return 0;

    return valor is int
        ? valor.toDouble()
        : valor;
  }
}
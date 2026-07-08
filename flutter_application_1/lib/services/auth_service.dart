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
        'objetivo': '',
        'idade': 0,
        'peso': 0.0,
        'diasSemana': 0,
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

    if (resultado.isEmpty) {
      return false;
    }

    usuarioLogado = Map<String, dynamic>.from(resultado.first);
    return true;
  }


  Future<void> salvarObjetivo(String objetivo) async {
    Database db = await DatabaseHelper.getDatabase();

    await db.update(
      'usuarios',
      {'objetivo': objetivo},
      where: 'id = ?',
      whereArgs: [usuarioLogado!['id']],
    );

    usuarioLogado!['objetivo'] = objetivo;
  }


  Future<void> salvarDadosUsuario({
    required int idade,
    required double peso,
  }) async {
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


  Future<void> salvarDiasSemana(int dias) async {
    Database db = await DatabaseHelper.getDatabase();

    await db.update(
      'usuarios',
      {
        'diasSemana': dias,
      },
      where: 'id = ?',
      whereArgs: [usuarioLogado!['id']],
    );

    usuarioLogado!['diasSemana'] = dias;
  }


  Future<void> atualizarUsuarioLogado() async {
    Database db = await DatabaseHelper.getDatabase();

    List<Map<String, dynamic>> resultado = await db.query(
      'usuarios',
      where: 'id = ?',
      whereArgs: [usuarioLogado!['id']],
    );

    if (resultado.isNotEmpty) {
      usuarioLogado = Map<String, dynamic>.from(resultado.first);
    }
  }


  // ==========================
  // PLANO DE TREINO
  // ==========================


  Future<void> limparPlano() async {
    Database db = await DatabaseHelper.getDatabase();

    await db.delete(
      'plano',
      where: 'usuarioId = ?',
      whereArgs: [usuarioLogado!['id']],
    );
  }


  Future<void> salvarTreino(String dia, String treino) async {
    Database db = await DatabaseHelper.getDatabase();

    await db.insert(
      'plano',
      {
        'usuarioId': usuarioLogado!['id'],
        'dia': dia,
        'treino': treino,
        'concluido': 0,
      },
    );
  }


  Future<List<Map<String, dynamic>>> carregarPlano() async {
    Database db = await DatabaseHelper.getDatabase();

    return await db.query(
      'plano',
      where: 'usuarioId = ?',
      whereArgs: [usuarioLogado!['id']],
      orderBy: 'id',
    );
  }


  static String get nome => usuarioLogado?['nome'] ?? '';

  static String get objetivo => usuarioLogado?['objetivo'] ?? '';

  static int get idade => usuarioLogado?['idade'] ?? 0;


  static double get peso {
    final valor = usuarioLogado?['peso'];

    if (valor == null) return 0;

    if (valor is int) {
      return valor.toDouble();
    }

    return valor;
  }


  static int get diasSemana => usuarioLogado?['diasSemana'] ?? 0;
}
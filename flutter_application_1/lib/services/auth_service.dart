import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';

class AuthService {
  static Map<String, dynamic>? usuarioLogado;

  // ==========================
  // CADASTRO
  // ==========================

  Future<void> cadastrar(
    String nome,
    String senha,
  ) async {
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

  // ==========================
  // LOGIN
  // ==========================

  Future<bool> login(
    String nome,
    String senha,
  ) async {
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

  // ==========================
  // SALVAR OBJETIVO
  // ==========================

  Future<void> salvarObjetivo(String objetivo) async {
    Database db = await DatabaseHelper.getDatabase();

    await db.update(
      'usuarios',
      {
        'objetivo': objetivo,
      },
      where: 'id = ?',
      whereArgs: [usuarioLogado!['id']],
    );

    usuarioLogado!['objetivo'] = objetivo;
  }

  // ==========================
  // SALVAR IDADE E PESO
  // ==========================

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

  // ==========================
  // SALVAR DIAS
  // ==========================

  Future<void> salvarDiasSemana(int diasSemana) async {
    Database db = await DatabaseHelper.getDatabase();

    await db.update(
      'usuarios',
      {
        'diasSemana': diasSemana,
      },
      where: 'id = ?',
      whereArgs: [usuarioLogado!['id']],
    );

    usuarioLogado!['diasSemana'] = diasSemana;
  }

  // ==========================
  // ATUALIZAR USUÁRIO LOGADO
  // ==========================

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
  // GETTERS
  // ==========================

  static String get nome =>
      usuarioLogado?['nome'] ?? '';

  static String get objetivo =>
      usuarioLogado?['objetivo'] ?? '';

  static int get idade =>
      usuarioLogado?['idade'] ?? 0;

  static double get peso {
    final valor = usuarioLogado?['peso'];

    if (valor == null) return 0;

    if (valor is int) return valor.toDouble();

    return valor;
  }

  static int get diasSemana =>
      usuarioLogado?['diasSemana'] ?? 0;
}
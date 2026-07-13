import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';

class AuthService {
  static Map<String, dynamic>? usuarioLogado;

  Future<void> cadastrar(String nome, String senha) async {
    final Database db = await DatabaseHelper.getDatabase();

    await db.insert('usuarios', {
      'nome': nome,
      'senha': senha,
      'objetivo': '',
      'idade': 0,
      'peso': 0.0,
      'diasSemana': 0,
    });
  }

  Future<bool> login(String nome, String senha) async {
    final Database db = await DatabaseHelper.getDatabase();

    final resultado = await db.query(
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

  Future<void> adicionarAlerta(
    String titulo,
    String descricao,
  ) async {
    final Database db = await DatabaseHelper.getDatabase();

    await db.insert(
      'alertas',
      {
        'titulo': titulo,
        'descricao': descricao,
        'lido': 0,
      },
    );
  }

  Future<List<Map<String, dynamic>>> carregarAlertas() async {
    final Database db = await DatabaseHelper.getDatabase();

    return await db.query(
      'alertas',
      orderBy: 'id DESC',
    );
  }

  Future<void> salvarObjetivo(String objetivo) async {
    if (usuarioLogado == null) return;

    final Database db = await DatabaseHelper.getDatabase();

    await db.update(
      'usuarios',
      {
        'objetivo': objetivo,
      },
      where: 'id = ?',
      whereArgs: [
        usuarioLogado!['id'],
      ],
    );

    usuarioLogado!['objetivo'] = objetivo;
  }

  Future<void> salvarDadosUsuario({
    required int idade,
    required double peso,
  }) async {
    if (usuarioLogado == null) return;

    final Database db = await DatabaseHelper.getDatabase();

    await db.update(
      'usuarios',
      {
        'idade': idade,
        'peso': peso,
      },
      where: 'id = ?',
      whereArgs: [
        usuarioLogado!['id'],
      ],
    );

    usuarioLogado!['idade'] = idade;
    usuarioLogado!['peso'] = peso;
  }

  Future<void> salvarDiasSemana(int dias) async {
    if (usuarioLogado == null) return;

    final Database db = await DatabaseHelper.getDatabase();

    await db.update(
      'usuarios',
      {
        'diasSemana': dias,
      },
      where: 'id = ?',
      whereArgs: [
        usuarioLogado!['id'],
      ],
    );

    usuarioLogado!['diasSemana'] = dias;
  }

  Future<void> atualizarUsuarioLogado() async {
    if (usuarioLogado == null) return;

    final Database db = await DatabaseHelper.getDatabase();

    final resultado = await db.query(
      'usuarios',
      where: 'id = ?',
      whereArgs: [
        usuarioLogado!['id'],
      ],
    );

    if (resultado.isNotEmpty) {
      usuarioLogado = Map<String, dynamic>.from(
        resultado.first,
      );
    }
  }

  // ==========================
  // PLANO DE TREINO
  // ==========================

  Future<void> limparPlano() async {
    if (usuarioLogado == null) return;

    final Database db = await DatabaseHelper.getDatabase();

    await db.delete(
      'plano',
      where: 'usuarioId = ?',
      whereArgs: [
        usuarioLogado!['id'],
      ],
    );
  }

  Future<void> salvarTreino(
    String dia,
    String treino,
    String exercicios,
  ) async {
    if (usuarioLogado == null) return;

    final Database db = await DatabaseHelper.getDatabase();

    await db.insert(
      'plano',
      {
        'usuarioId': usuarioLogado!['id'],
        'dia': dia,
        'treino': treino,
        'exercicios': exercicios,
        'concluido': 0,
      },
    );
  }

  Future<List<Map<String, dynamic>>> carregarPlano() async {
    if (usuarioLogado == null) {
      return [];
    }

    final Database db = await DatabaseHelper.getDatabase();

    return await db.query(
      'plano',
      where: 'usuarioId = ?',
      whereArgs: [
        usuarioLogado!['id'],
      ],
      orderBy: 'id',
    );
  }

  Future<void> concluirTreino(int id) async {
    if (usuarioLogado == null) return;

    final Database db = await DatabaseHelper.getDatabase();

    await db.update(
      'plano',
      {
        'concluido': 1,
      },
      where: 'id = ?',
      whereArgs: [id],
    );

    final treino = await db.query(
      'plano',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (treino.isNotEmpty) {
      await db.insert(
        'historico',
        {
          'usuarioId': usuarioLogado!['id'],
          'treino': treino.first['treino'],
          'data': DateTime.now().toIso8601String(),
        },
      );
    }
  }

  List<Map<String, String>> buscarExercicios(
    dynamic treino,
  ) {
    final String nomeTreino =
        treino?.toString().toLowerCase() ?? '';

    if (nomeTreino.contains('peito')) {
      return [
        {
          'nome': 'Supino reto',
          'series': '4',
          'repeticoes': '12',
          'descanso': '60s',
        },
        {
          'nome': 'Supino inclinado',
          'series': '3',
          'repeticoes': '12',
          'descanso': '60s',
        },
        {
          'nome': 'Crucifixo',
          'series': '3',
          'repeticoes': '15',
          'descanso': '45s',
        },
      ];
    }

    if (nomeTreino.contains('perna')) {
      return [
        {
          'nome': 'Agachamento',
          'series': '4',
          'repeticoes': '12',
          'descanso': '60s',
        },
        {
          'nome': 'Leg press',
          'series': '4',
          'repeticoes': '12',
          'descanso': '60s',
        },
        {
          'nome': 'Cadeira extensora',
          'series': '3',
          'repeticoes': '15',
          'descanso': '45s',
        },
      ];
    }

    if (nomeTreino.contains('costas')) {
      return [
        {
          'nome': 'Puxada frontal',
          'series': '4',
          'repeticoes': '12',
          'descanso': '60s',
        },
        {
          'nome': 'Remada baixa',
          'series': '3',
          'repeticoes': '12',
          'descanso': '60s',
        },
        {
          'nome': 'Remada unilateral',
          'series': '3',
          'repeticoes': '12',
          'descanso': '45s',
        },
      ];
    }

    if (nomeTreino.contains('hiit') ||
        nomeTreino.contains('tabata')) {
      return [
        {
          'nome': 'Polichinelo',
          'series': '4',
          'repeticoes': '30s',
          'descanso': '15s',
        },
        {
          'nome': 'Mountain climber',
          'series': '4',
          'repeticoes': '30s',
          'descanso': '15s',
        },
        {
          'nome': 'Burpee',
          'series': '4',
          'repeticoes': '30s',
          'descanso': '20s',
        },
      ];
    }

    return [
      {
        'nome': 'Agachamento',
        'series': '3',
        'repeticoes': '12',
        'descanso': '60s',
      },
      {
        'nome': 'Flexão',
        'series': '3',
        'repeticoes': '10',
        'descanso': '45s',
      },
      {
        'nome': 'Prancha',
        'series': '3',
        'repeticoes': '30s',
        'descanso': '30s',
      },
    ];
  }

  static String get nome {
    return usuarioLogado?['nome']?.toString() ?? '';
  }

  static String get objetivo {
    return usuarioLogado?['objetivo']?.toString() ?? '';
  }

  static int get idade {
    final valor = usuarioLogado?['idade'];

    if (valor is int) {
      return valor;
    }

    return int.tryParse(
          valor?.toString() ?? '',
        ) ??
        0;
  }

  static double get peso {
    final valor = usuarioLogado?['peso'];

    if (valor == null) {
      return 0.0;
    }

    if (valor is num) {
      return valor.toDouble();
    }

    return double.tryParse(
          valor.toString(),
        ) ??
        0.0;
  }

  static int get diasSemana {
    final valor = usuarioLogado?['diasSemana'];

    if (valor is int) {
      return valor;
    }

    return int.tryParse(
          valor?.toString() ?? '',
        ) ??
        0;
  }
}
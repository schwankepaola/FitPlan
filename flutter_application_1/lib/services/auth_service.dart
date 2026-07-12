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


 Future<void> salvarTreino(
  String dia,
  String treino,
  String exercicios,
) async {
  Database db = await DatabaseHelper.getDatabase();

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
  Future<void> concluirTreino(int id) async {

  Database db = await DatabaseHelper.getDatabase();

  await db.update(
    'plano',
    {
      'concluido': 1,
    },
    where: 'id = ?',
    whereArgs: [id],
  );

}
List<Map<String, String>> buscarExercicios(String treino) {
  switch (treino) {
    case "Peito & Tríceps":
      return [
        {
          "nome": "Supino Reto",
          "series": "4",
          "repeticoes": "10",
          "descanso": "60s",
        },
        {
          "nome": "Supino Inclinado",
          "series": "4",
          "repeticoes": "12",
          "descanso": "60s",
        },
        {
          "nome": "Crucifixo",
          "series": "3",
          "repeticoes": "12",
          "descanso": "45s",
        },
        {
          "nome": "Tríceps Testa",
          "series": "3",
          "repeticoes": "10",
          "descanso": "45s",
        },
      ];

    case "Costas & Bíceps":
      return [
        {
          "nome": "Puxada Frontal",
          "series": "4",
          "repeticoes": "12",
          "descanso": "60s",
        },
        {
          "nome": "Remada Curvada",
          "series": "4",
          "repeticoes": "10",
          "descanso": "60s",
        },
        {
          "nome": "Rosca Direta",
          "series": "3",
          "repeticoes": "12",
          "descanso": "45s",
        },
        {
          "nome": "Rosca Martelo",
          "series": "3",
          "repeticoes": "10",
          "descanso": "45s",
        },
      ];

    case "Pernas & Glúteos":
      return [
        {
          "nome": "Agachamento",
          "series": "4",
          "repeticoes": "10",
          "descanso": "90s",
        },
        {
          "nome": "Leg Press",
          "series": "4",
          "repeticoes": "12",
          "descanso": "90s",
        },
        {
          "nome": "Extensora",
          "series": "3",
          "repeticoes": "15",
          "descanso": "60s",
        },
        {
          "nome": "Stiff",
          "series": "3",
          "repeticoes": "12",
          "descanso": "60s",
        },
      ];

    case "Ombros & Core":
      return [
        {
          "nome": "Desenvolvimento",
          "series": "4",
          "repeticoes": "10",
          "descanso": "60s",
        },
        {
          "nome": "Elevação Lateral",
          "series": "3",
          "repeticoes": "12",
          "descanso": "45s",
        },
        {
          "nome": "Prancha",
          "series": "3",
          "repeticoes": "40s",
          "descanso": "30s",
        },
        {
          "nome": "Abdominal",
          "series": "3",
          "repeticoes": "20",
          "descanso": "30s",
        },
      ];

    case "Cardio":
      return [
        {
          "nome": "Corrida",
          "series": "1",
          "repeticoes": "20 min",
          "descanso": "-",
        },
        {
          "nome": "Bicicleta",
          "series": "1",
          "repeticoes": "15 min",
          "descanso": "-",
        },
        {
          "nome": "Elíptico",
          "series": "1",
          "repeticoes": "15 min",
          "descanso": "-",
        },
        {
          "nome": "Corda",
          "series": "5",
          "repeticoes": "1 min",
          "descanso": "30s",
        },
      ];

    case "Full Body":
      return [
        {
          "nome": "Agachamento",
          "series": "3",
          "repeticoes": "12",
          "descanso": "60s",
        },
        {
          "nome": "Supino",
          "series": "3",
          "repeticoes": "12",
          "descanso": "60s",
        },
        {
          "nome": "Remada",
          "series": "3",
          "repeticoes": "12",
          "descanso": "60s",
        },
        {
          "nome": "Prancha",
          "series": "3",
          "repeticoes": "40s",
          "descanso": "30s",
        },
      ];

    case "Alongamento":
      return [
        {
          "nome": "Mobilidade",
          "series": "2",
          "repeticoes": "10",
          "descanso": "20s",
        },
        {
          "nome": "Alongamentos",
          "series": "2",
          "repeticoes": "30s",
          "descanso": "20s",
        },
        {
          "nome": "Liberação Miofascial",
          "series": "1",
          "repeticoes": "5 min",
          "descanso": "-",
        },
        {
          "nome": "Relaxamento",
          "series": "1",
          "repeticoes": "5 min",
          "descanso": "-",
        },
      ];

    default:
      return [
        {
          "nome": "Treino não encontrado",
          "series": "-",
          "repeticoes": "-",
          "descanso": "-",
        }
      ];
  }
}
}

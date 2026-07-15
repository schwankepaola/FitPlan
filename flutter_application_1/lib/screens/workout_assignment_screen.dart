import 'package:flutter/material.dart';
import '../services/auth_service.dart';

// Tela onde o usuário escolhe em quais dias da semana fará cada treino.
class WorkoutAssignmentScreen extends StatefulWidget {
  const WorkoutAssignmentScreen({super.key});

  @override
  State<WorkoutAssignmentScreen> createState() =>
      _WorkoutAssignmentScreenState();
}

class _WorkoutAssignmentScreenState extends State<WorkoutAssignmentScreen> {
  final Color verde = const Color(0xFFC6FF00);
  int quantidadeDias = 4;

  final List<String> diasSemana = [
    "Seg",
    "Ter",
    "Qua",
    "Qui",
    "Sex",
    "Sáb",
    "Dom",
  ];

  List<String> treinosDisponiveis = [
    "Peito & Tríceps",
    "Costas & Bíceps",
    "Pernas & Glúteos",
    "Ombros & Core",
  ];

  Map<String, String> planoSemana = {};

  // Guarda qual treino está sendo editado.
  int treinoAtual = 0;

  // Lista com todos os treinos e seus respectivos exercícios.
  final List<Map<String, dynamic>> treinos = [
    {
      "nome": "Peito & Tríceps",
      "exercicios": [
        "Supino Reto",
        "Supino Inclinado",
        "Crucifixo",
        "Tríceps Testa",
      ],
    },
    {
      "nome": "Costas & Bíceps",
      "exercicios": [
        "Puxada Frontal",
        "Remada",
        "Rosca Direta",
        "Rosca Martelo",
      ],
    },
    {
      "nome": "Pernas & Glúteos",
      "exercicios": ["Agachamento", "Leg Press", "Extensora", "Stiff"],
    },
    {
      "nome": "Ombros & Core",
      "exercicios": [
        "Desenvolvimento",
        "Elevação Lateral",
        "Prancha",
        "Abdominal",
      ],
    },
    {
      "nome": "Cardio",
      "exercicios": ["Corrida", "Bicicleta", "Elíptico", "Corda"],
    },
    {
      "nome": "Full Body",
      "exercicios": ["Agachamento", "Supino", "Remada", "Prancha"],
    },
    {
      "nome": "Alongamento",
      "exercicios": ["Mobilidade", "Alongamento", "Liberação", "Relaxamento"],
    },
  ];

  final List<String> dias = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"];

  // Armazena o dia escolhido para cada treino.
  final Map<int, String> diasEscolhidos = {};

  @override
  Widget build(BuildContext context) {

    // Recebe a quantidade de dias escolhida na tela anterior.
    quantidadeDias = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "ESCOLHA OS DIAS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const Text(
                "Atribua cada treino a um dia da semana.",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 20),

              // Mostra os treinos e o dia escolhido para cada um.
              ...List.generate(
                quantidadeDias,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          treinos[index]["nome"],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Text(
                        diasEscolhidos[index] ?? "Não definido",
                        style: TextStyle(
                          color: diasEscolhidos[index] == null
                              ? Colors.grey
                              : verde,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Botões para selecionar qual treino será configurado.
              Row(
                children: List.generate(quantidadeDias, (index) {
                  final ativo = treinoAtual == index;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          treinoAtual = index;
                        });
                      },
                      child: Container(
                        height: 42,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: ativo ? verde : Colors.white12,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            treinos[index]["nome"]
                                .toString()
                                .split("&")
                                .first
                                .trim(),
                            style: TextStyle(
                              color: ativo ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              // Exibe os exercícios do treino selecionado.
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xff111111),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      treinos[treinoAtual]["nome"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    ...((treinos[treinoAtual]["exercicios"] as List)
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              "• $e",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                        .toList()),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "ESCOLHA O DIA",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // Permite escolher o dia da semana para o treino atual.
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: dias.map((dia) {
                  final selecionado = diasEscolhidos[treinoAtual] == dia;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        diasEscolhidos[treinoAtual] = dia;
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 42,
                      decoration: BoxDecoration(
                        color: selecionado ? verde : const Color(0xff111111),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          dia,
                          style: TextStyle(
                            color: selecionado ? Colors.black : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Exibe um resumo do plano antes de salvar.
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff111111),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "RESUMO DA SEMANA",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    ...List.generate(
                      quantidadeDias,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                treinos[index]["nome"],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Text(
                              diasEscolhidos[index] ?? "Não definido",
                              style: TextStyle(
                                color: diasEscolhidos[index] == null
                                    ? Colors.grey
                                    : verde,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Salva o plano de treino e abre a tela inicial.
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: verde,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () async {

                    // Remove o plano anterior.
                    await AuthService().limparPlano();

                    // Salva todos os treinos escolhidos.
                    for (int i = 0; i < quantidadeDias; i++) {
                      if (diasEscolhidos[i] != null) {
                        await AuthService().salvarTreino(
                          diasEscolhidos[i]!,
                          treinos[i]["nome"],
                          (treinos[i]["exercicios"] as List).join("\n"),
                        );
                      }
                    }

                    if (!mounted) return;

                    // Vai para a tela principal do aplicativo.
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "SALVAR PLANO",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
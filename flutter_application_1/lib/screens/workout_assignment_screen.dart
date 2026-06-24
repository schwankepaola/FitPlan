import 'package:flutter/material.dart';

class WorkoutAssignmentScreen extends StatefulWidget {
  const WorkoutAssignmentScreen({super.key});

  @override
  State<WorkoutAssignmentScreen> createState() =>
      _WorkoutAssignmentScreenState();
}

class _WorkoutAssignmentScreenState
    extends State<WorkoutAssignmentScreen> {
  final Color verde = const Color(0xFFC6FF00);

  int treinoAtual = 0;

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
      "exercicios": [
        "Agachamento",
        "Leg Press",
        "Extensora",
        "Stiff",
      ],
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
  ];

  final List<String> dias = [
    "Dom",
    "Seg",
    "Ter",
    "Qua",
    "Qui",
    "Sex",
    "Sáb",
  ];

  final Map<int, String> diasEscolhidos = {};

  @override
  Widget build(BuildContext context) {
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

              Row(
                children: List.generate(
                  4,
                  (index) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 4,
                      color: index <= treinoAtual
                          ? verde
                          : Colors.white12,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: List.generate(
                  4,
                  (index) {
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
                              ["Peito", "Costas", "Pernas", "Ombros"][index],
                              style: TextStyle(
                                color:
                                    ativo ? Colors.white : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

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
                            padding:
                                const EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              "• $e",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
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

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: dias.map((dia) {
                  final selecionado =
                      diasEscolhidos[treinoAtual] == dia;

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
                        color: selecionado
                            ? verde
                            : const Color(0xff111111),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          dia,
                          style: TextStyle(
                            color: selecionado
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

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
                      4,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                treinos[index]["nome"],
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              diasEscolhidos[index] ??
                                  "Não definido",
                              style: TextStyle(
                                color:
                                    diasEscolhidos[index] == null
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

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: verde,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/workout_done',
                    );
                  },
                  child: const Text(
                    "SALVAR PLANO",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
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
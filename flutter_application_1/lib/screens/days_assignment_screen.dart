import 'package:flutter/material.dart';

class DaysAssignmentScreen extends StatefulWidget {
  const DaysAssignmentScreen({super.key});

  @override
  State<DaysAssignmentScreen> createState() => _DaysAssignmentScreenState();
}

class _DaysAssignmentScreenState extends State<DaysAssignmentScreen> {
  final Color verde = const Color(0xFFC6FF00);

  final List<String> diasSemana = [
    "Dom",
    "Seg",
    "Ter",
    "Qua",
    "Qui",
    "Sex",
    "Sáb",
  ];

  final List<Map<String, dynamic>> gruposBase = [
    {
      "nome": "Peito & Tríceps",
      "exercicios": [
        "Supino Reto",
        "Supino Inclinado",
        "Crucifixo",
        "Tríceps Testa",
      ]
    },
    {
      "nome": "Costas & Bíceps",
      "exercicios": [
        "Puxada Frontal",
        "Remada",
        "Rosca Direta",
        "Rosca Martelo",
      ]
    },
    {
      "nome": "Pernas & Glúteos",
      "exercicios": [
        "Agachamento",
        "Leg Press",
        "Cadeira Extensora",
        "Stiff",
      ]
    },
    {
      "nome": "Ombros & Core",
      "exercicios": [
        "Desenvolvimento",
        "Elevação Lateral",
        "Prancha",
        "Abdominal",
      ]
    },
    {
      "nome": "Cardio",
      "exercicios": [
        "Corrida",
        "Bicicleta",
        "Esteira",
      ]
    },
    {
      "nome": "Full Body",
      "exercicios": [
        "Agachamento",
        "Supino",
        "Remada",
      ]
    },
    {
      "nome": "Mobilidade",
      "exercicios": [
        "Alongamentos",
        "Mobilidade Articular",
      ]
    },
  ];

  int grupoAtual = 0;

  final Map<int, String> atribuicoes = {};

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    final int quantidadeDias = args is int ? args : 4;

    final grupos = gruposBase.take(quantidadeDias).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "ESCOLHA OS DIAS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Atribua cada treino a um dia da semana.",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: List.generate(
                  grupos.length,
                  (index) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 4,
                      color: index <= grupoAtual
                          ? verde
                          : Colors.white12,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: grupos.length,
                  itemBuilder: (context, index) {
                    final ativo = grupoAtual == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          grupoAtual = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: ativo
                                ? verde
                                : Colors.white12,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            grupos[index]["nome"]
                                .toString()
                                .split("&")
                                .first
                                .trim(),
                            style: TextStyle(
                              color: ativo
                                  ? Colors.white
                                  : Colors.grey,
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
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff111111),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      grupos[grupoAtual]["nome"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (grupos[grupoAtual]
                              ["exercicios"] as List)
                          .map(
                            (e) => Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xff1a1a1a),
                                borderRadius:
                                    BorderRadius.circular(
                                        12),
                              ),
                              child: Text(
                                e.toString(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "ESCOLHA O DIA",
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 1,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: diasSemana.map((dia) {
                  final selecionado =
                      atribuicoes[grupoAtual] == dia;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        atribuicoes[grupoAtual] = dia;
                      });
                    },
                    child: Container(
                      width: 55,
                      height: 42,
                      decoration: BoxDecoration(
                        color: selecionado
                            ? verde
                            : const Color(0xff111111),
                        borderRadius:
                            BorderRadius.circular(12),
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

              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xff111111),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "RESUMO DA SEMANA",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...List.generate(
                        grupos.length,
                        (index) => Padding(
                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                            children: [
                              Text(
                                grupos[index]["nome"],
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                atribuicoes[index] ??
                                    "Não definido",
                                style: TextStyle(
                                  color: atribuicoes[index] ==
                                          null
                                      ? Colors.grey
                                      : verde,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

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
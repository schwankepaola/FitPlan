// Importa os componentes visuais do Flutter.
import 'package:flutter/material.dart';

// Cria a tela para atribuição dos dias de treino.
// StatefulWidget é utilizado porque o usuário pode alterar os dias selecionados.
class DaysAssignmentScreen extends StatefulWidget {
  const DaysAssignmentScreen({super.key});

  @override
  State<DaysAssignmentScreen> createState() =>
      _DaysAssignmentScreenState();
}

// Classe responsável por controlar o estado da tela.
class _DaysAssignmentScreenState
    extends State<DaysAssignmentScreen> {

  // Cor verde utilizada em diversos elementos da interface.
  final Color verde = const Color(0xFFC6FF00);

  // Lista com os dias da semana.
  final List<String> diasSemana = [
    "Dom",
    "Seg",
    "Ter",
    "Qua",
    "Qui",
    "Sex",
    "Sáb",
  ];

  // Lista contendo todos os grupos musculares e seus exercícios.
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

  // Armazena qual grupo está sendo exibido no momento.
  int grupoAtual = 0;

  // Guarda o dia da semana escolhido para cada grupo.
  // Exemplo: grupo 0 → Segunda-feira.
  final Map<int, String> atribuicoes = {};

  @override
  Widget build(BuildContext context) {

    // Recebe a quantidade de dias escolhida na tela anterior.
    final args = ModalRoute.of(context)?.settings.arguments;

    // Caso nenhum valor seja recebido, utiliza 4 dias como padrão.
    final int quantidadeDias = args is int ? args : 4;

    // Seleciona apenas a quantidade de grupos necessária.
    final grupos = gruposBase.take(quantidadeDias).toList();

    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              // Título principal da tela.
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

              // Texto explicativo.
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

              // Barra de progresso indicando em qual treino o usuário está.
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

              // Lista horizontal dos grupos musculares.
              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: grupos.length,

                  itemBuilder: (context, index) {

                    // Verifica se este grupo está selecionado.
                    final ativo = grupoAtual == index;

                    return GestureDetector(

                      // Ao tocar em um grupo, ele passa a ser exibido.
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

              // Card mostrando o treino atual.
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: const Color(0xff111111),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    // Nome do grupo muscular.
                    Text(
                      grupos[grupoAtual]["nome"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Lista dos exercícios do grupo.
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,

                      children: (grupos[grupoAtual]["exercicios"] as List)
                          .map(
                            (e) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),

                              decoration: BoxDecoration(
                                color: const Color(0xff1a1a1a),
                                borderRadius:
                                    BorderRadius.circular(12),
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

              // Texto indicando que o usuário deve escolher um dia.
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

              // Botões com os dias da semana.
              Wrap(
                spacing: 8,
                runSpacing: 8,

                children: diasSemana.map((dia) {

                  // Verifica se este dia está selecionado.
                  final selecionado =
                      atribuicoes[grupoAtual] == dia;

                  return GestureDetector(

                    // Salva o dia escolhido.
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

              // Card que mostra o resumo dos dias escolhidos.
              Expanded(
                child: Container(
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

                      const SizedBox(height: 12),

                      // Exibe todos os grupos e seus respectivos dias.
                      ...List.generate(
                        grupos.length,

                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                          ),

                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,

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
                                  color: atribuicoes[index] == null
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
              ),

              const SizedBox(height: 15),

              // Botão para salvar o plano de treino.
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: verde,
                    foregroundColor: Colors.black,
                  ),

                  // Ao clicar, vai para a tela de conclusão.
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
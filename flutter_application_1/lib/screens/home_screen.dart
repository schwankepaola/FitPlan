import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color verde = const Color(0xFFC6FF00);

  List<Map<String, dynamic>> plano = [];
  bool carregando = true;

  String get nomeUsuario => AuthService.nome;
  int get idadeUsuario => AuthService.idade;
  double get pesoUsuario => AuthService.peso;
  int get diasSemanaUsuario => AuthService.diasSemana;

  @override
  void initState() {
    super.initState();
    carregarPlano();
  }

  Future<void> carregarPlano() async {
    final resultado = await AuthService().carregarPlano();

    setState(() {
      plano = resultado;
      carregando = false;
    });
  }

  int calcularProgresso() {
    if (plano.isEmpty) return 0;

    final concluidos = plano.where((t) => t["concluido"] == 1).length;

    return ((concluidos / plano.length) * 100).round();
  }

  String abreviarDia(String dia) {
    switch (dia.toLowerCase()) {
      case "segunda":
        return "SEG";
      case "terça":
      case "terca":
        return "TER";
      case "quarta":
        return "QUA";
      case "quinta":
        return "QUI";
      case "sexta":
        return "SEX";
      case "sábado":
      case "sabado":
        return "SAB";
      case "domingo":
        return "DOM";
      default:
        return dia.substring(0, 3).toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xff2A2A2A),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bem-vindo",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),

                        Text(
                          nomeUsuario,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xff1B1B1B),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/profile");
                      },
                      icon: const Icon(Icons.settings, color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xff171717),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: verde,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            "Plano",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/history");
                        },
                        child: const Center(
                          child: Text(
                            "Histórico",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: InkWell(
                        onTap: () {
                         Navigator.pushNamed(context, "/alerts"); 
                        },
                        child: const Center(
                          child: Text(
                            "Alertas",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff171717),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: verde,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            AuthService.objetivo.isEmpty
                                ? "SEM OBJETIVO"
                                : AuthService.objetivo.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const Spacer(),

                        Text(
                          "${calcularProgresso()}%",
                          style: TextStyle(
                            color: verde,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$idadeUsuario anos",
                          style: const TextStyle(color: Colors.grey),
                        ),

                        Text(
                          "${pesoUsuario.toStringAsFixed(0)} kg",
                          style: const TextStyle(color: Colors.grey),
                        ),

                        Text(
                          "${diasSemanaUsuario}x/sem",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        minHeight: 8,
                        value: plano.isEmpty
                            ? 0
                            : plano.where((t) => t["concluido"] == 1).length /
                                  plano.length,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation<Color>(verde),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${plano.where((t) => t["concluido"] == 1).length}/${plano.length} treinos",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              if (carregando)
                const CircularProgressIndicator()
              else if (plano.isEmpty)
                const Text(
                  "Nenhum treino salvo",
                  style: TextStyle(color: Colors.grey),
                )
              else
                ...plano.map((treino) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      color: const Color(0xff171717),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white10),
                    ),

                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),

                      childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),

                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white,

                      leading: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(15),
                        ),

                        child: Center(
                          child: Text(
                            abreviarDia(treino["dia"]),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      title: Text(
                        treino["treino"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      subtitle: Text(
                        treino["dia"],
                        style: const TextStyle(color: Colors.grey),
                      ),

                      children: [
                        const Divider(color: Colors.white12),

                        const Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                "Exercício",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Séries",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Reps",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Desc.",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),
                        Column(
                          children: AuthService()
                              .buscarExercicios(treino["treino"])
                              .map<Widget>((exercicio) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff232323),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: verde.withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.fitness_center,
                                          color: verde,
                                          size: 18,
                                        ),
                                      ),

                                      const SizedBox(width: 12),

                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          exercicio["nome"]!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        child: Text(
                                          exercicio["series"]!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        child: Text(
                                          exercicio["repeticoes"]!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        child: Text(
                                          exercicio["descanso"]!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: verde,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })
                              .toList(),
                        ),

                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: treino["concluido"] == 1
                                  ? Colors.green
                                  : verde,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () async {
                              await AuthService().concluirTreino(treino["id"]);

                              await AuthService().adicionarAlerta(
                                "Treino concluído",
                                "Você concluiu o treino ${treino["treino"]}.",
                              );

                              await carregarPlano();

                              if (!mounted) return;

                              NotificationService.showTestNotification();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Treino concluído com sucesso!",
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              treino["concluido"] == 1
                                  ? "TREINO CONCLUÍDO ✓"
                                  : "MARCAR COMO CONCLUÍDO",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

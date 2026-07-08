import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import '../services/auth_service.dart';

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

    int concluidos = plano.where((treino) => treino['concluido'] == 1).length;

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
          padding: const EdgeInsets.all(14),

          child: Column(
            children: [
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "FIT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextSpan(
                          text: "PLAN",
                          style: TextStyle(
                            color: Color(0xFFC6FF00),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  Text(
                    "Olá, $nomeUsuario",
                    style: const TextStyle(color: Colors.white),
                  ),

                  const SizedBox(width: 8),

                  const Icon(Icons.settings, color: Colors.grey),
                ],
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color(0xff111111),

                  borderRadius: BorderRadius.circular(18),
                ),

                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Ganhar Massa",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Spacer(),

                        Text(
                          "${calcularProgresso()}%",

                          style: TextStyle(
                            color: verde,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Text(
                          "$idadeUsuario anos",
                          style: const TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(width: 20),

                        Text(
                          "${pesoUsuario.toStringAsFixed(0)} kg",
                          style: const TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(width: 20),

                        Text(
                          "${diasSemanaUsuario}x/sem",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    LinearProgressIndicator(
                      value: plano.isEmpty
                          ? 0
                          : plano.where((t) => t['concluido'] == 1).length /
                                plano.length,

                      backgroundColor: Colors.white10,

                      valueColor: AlwaysStoppedAnimation<Color>(verde),
                    ),

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerRight,

                      child: Text(
                        "${plano.where((t) => t['concluido'] == 1).length}/${plano.length} treinos",

                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              if (carregando)
                const CircularProgressIndicator()
              else if (plano.isEmpty)
                const Text(
                  "Nenhum treino salvo",
                  style: TextStyle(color: Colors.grey),
                )
              else
                ...plano.map(
                  (treino) => Card(
                    color: const Color(0xff111111),

                    child: ExpansionTile(
                      iconColor: Colors.white,

                      collapsedIconColor: Colors.white,

                      leading: Container(
                        width: 45,

                        height: 45,

                        decoration: BoxDecoration(
                          color: Colors.white10,

                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Center(
                          child: Text(
                            abreviarDia(treino['dia']),

                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      title: Text(
                        treino['dia'],

                        style: const TextStyle(color: Colors.white),
                      ),

                      subtitle: Text(
                        treino['treino'],

                        style: const TextStyle(color: Colors.grey),
                      ),

                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: treino['concluido'] == 1
                                ? Colors.green
                                : verde,
                            foregroundColor: Colors.black,
                          ),

                          onPressed: () async {
                            await AuthService().concluirTreino(treino['id']);

                            await carregarPlano();

                            if (!mounted) return;

                            NotificationService.showTestNotification();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Treino concluído com sucesso!"),
                              ),
                            );
                          },

                          child: Text(
                            treino['concluido'] == 1
                                ? "TREINO CONCLUÍDO ✓"
                                : "MARCAR COMO CONCLUÍDO",

                            style: const TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}

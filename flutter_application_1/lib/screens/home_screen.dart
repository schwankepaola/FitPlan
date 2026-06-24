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

  bool treinoSegundaExpandido = true;
  bool treinoConcluido = false;

  String get nomeUsuario => AuthService.nome;
  int get idadeUsuario => AuthService.idade;
  double get pesoUsuario => AuthService.peso;

  final List<Map<String, String>> exerciciosSegunda = [
    {"nome": "Supino Reto com Barra", "serie": "4x", "rep": "8-10"},
    {"nome": "Supino Inclinado com Halteres", "serie": "3x", "rep": "10-12"},
    {"nome": "Crucifixo na Polia", "serie": "3x", "rep": "12-15"},
    {"nome": "Tríceps Testa", "serie": "3x", "rep": "10-12"},
    {"nome": "Tríceps Corda no Cabo", "serie": "3x", "rep": "12-15"},
  ];

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
                  const Icon(
                    Icons.settings,
                    color: Colors.grey,
                    size: 18,
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xff171717),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xff0f0f0f),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            "Plano",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/history');
                        },
                        child: const Text("Histórico"),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/alerts');
                        },
                        child: const Text("Alertas"),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xff111111),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: verde,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Ganhar Massa",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          treinoConcluido ? "25%" : "0%",
                          style: TextStyle(
                            color: verde,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

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
                        const Text(
                          "4x/sem",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    LinearProgressIndicator(
                      value: treinoConcluido ? 0.25 : 0,
                      backgroundColor: Colors.white10,
                      valueColor: AlwaysStoppedAnimation<Color>(verde),
                    ),

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        treinoConcluido
                            ? "1/4 treinos"
                            : "0/4 treinos",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff111111),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            "SEG",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: const Text(
                        "Segunda",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        "Peito & Tríceps",
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          treinoSegundaExpandido
                              ? Icons.expand_less
                              : Icons.expand_more,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            treinoSegundaExpandido =
                                !treinoSegundaExpandido;
                          });
                        },
                      ),
                    ),

                    if (treinoSegundaExpandido)
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            ...exerciciosSegunda.map(
                              (e) => Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xff1b1b1b),
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        e["nome"]!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${e["serie"]} ${e["rep"]}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: treinoConcluido
                                      ? Colors.green
                                      : verde,
                                  foregroundColor: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    treinoConcluido = true;
                                  });

                                  NotificationService
                                      .showTestNotification();

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Treino concluído com sucesso!",
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  treinoConcluido
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
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
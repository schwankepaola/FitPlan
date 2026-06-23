import 'package:flutter/material.dart';

class DaysPerWeekScreen extends StatefulWidget {
  const DaysPerWeekScreen({super.key});

  @override
  State<DaysPerWeekScreen> createState() => _DaysPerWeekScreenState();
}

class _DaysPerWeekScreenState extends State<DaysPerWeekScreen> {
  int diasSelecionados = 1;

  final Color verde = const Color(0xFFC6FF00);

  Widget botaoDia(String texto, int valor) {
    final bool ativo = diasSelecionados == valor;

    return GestureDetector(
      onTap: () {
        setState(() {
          diasSelecionados = valor;
        });
      },
      child: Container(
        width: double.infinity,
        height: 60,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: ativo ? verde : const Color(0xff111111),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: ativo ? verde : Colors.white10,
          ),
        ),
        child: Center(
          child: Text(
            texto,
            style: TextStyle(
              color: ativo ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "FIT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "PLAN",
                          style: TextStyle(
                            color: Color(0xFFC6FF00),
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Plano de treino personalizado",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                        child: Container(height: 4, color: Color(0xFFC6FF00))),
                    const SizedBox(width: 5),
                    Expanded(
                        child: Container(height: 4, color: Color(0xFFC6FF00))),
                    const SizedBox(width: 5),
                    Expanded(
                        child: Container(height: 4, color: Color(0xFFC6FF00))),
                  ],
                ),
                const SizedBox(height: 40),
                const Text(
                  "Dias por semana",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Quantos dias você pode treinar?",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                botaoDia("1 Dia por Semana", 1),
                botaoDia("2 Dias por Semana", 2),
                botaoDia("3 Dias por Semana", 3),
                botaoDia("4 Dias por Semana", 4),
                botaoDia("5 Dias por Semana", 5),
                botaoDia("6 Dias por Semana", 6),
                botaoDia("7 Dias por Semana", 7),
                const SizedBox(height: 20),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Voltar",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFC6FF00),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/workout',
                              arguments: diasSelecionados,
                            );
                          },
                          child: const Text(
                            "GERAR MEU PLANO",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

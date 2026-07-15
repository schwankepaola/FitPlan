import 'package:flutter/material.dart';
import '../services/auth_service.dart';

// Tela onde o usuário escolhe o objetivo do treino.
class ObjectiveScreen extends StatefulWidget {
  const ObjectiveScreen({super.key});

  @override
  State<ObjectiveScreen> createState() => _ObjectiveScreenState();
}

class _ObjectiveScreenState extends State<ObjectiveScreen> {

  // Armazena o objetivo selecionado pelo usuário.
  String objetivoSelecionado = '';

  // Cor principal utilizada na interface.
  final Color verde = const Color(0xFFC6FF00);

  // Método que cria um card para cada objetivo disponível.
  Widget cardObjetivo(String titulo, String subtitulo, IconData icone) {

    // Verifica se este objetivo está selecionado.
    bool selecionado = objetivoSelecionado == titulo;

    return GestureDetector(

      // Atualiza o objetivo escolhido.
      onTap: () {
        setState(() {
          objetivoSelecionado = titulo;
        });
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: const Color(0xff111111),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selecionado ? verde : Colors.white10,
            width: 2,
          ),
        ),

        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icone, color: Colors.grey),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitulo,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 15),

              // Logo do aplicativo.
              RichText(
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
                        color: verde,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const Text(
                "Plano de treino personalizado",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              // Barra indicando o progresso do cadastro.
              Row(
                children: [
                  Expanded(child: Container(height: 4, color: verde)),
                  const SizedBox(width: 5),
                  Expanded(child: Container(height: 4, color: Colors.white10)),
                  const SizedBox(width: 5),
                  Expanded(child: Container(height: 4, color: Colors.white10)),
                ],
              ),

              const SizedBox(height: 40),

              const Text(
                "Qual é seu objetivo?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Escolha um objetivo para personalizar seu plano.",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              // Opções de objetivos disponíveis.
              cardObjetivo(
                "Ganhar Massa",
                "Hipertrofia e força",
                Icons.fitness_center,
              ),

              cardObjetivo(
                "Emagrecer",
                "Queima de gordura e cardio",
                Icons.local_fire_department,
              ),

              cardObjetivo(
                "Condicionamento",
                "Resistência e funcional",
                Icons.flash_on,
              ),

              const Spacer(),

              // Botão para salvar o objetivo e continuar.
              SizedBox(
                width: double.infinity,
                height: 60,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: verde,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  onPressed: () async {

                    // Verifica se algum objetivo foi selecionado.
                    if (objetivoSelecionado.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Selecione um objetivo para continuar',
                          ),
                        ),
                      );
                      return;
                    }

                    try {

                      // Salva o objetivo escolhido.
                      await AuthService().salvarObjetivo(
                        objetivoSelecionado,
                      );

                      if (!mounted) return;

                      // Avança para a próxima tela.
                      Navigator.pushNamed(context, '/user_data');

                    } catch (e) {

                      // Exibe uma mensagem caso ocorra algum erro.
                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Erro ao salvar objetivo: $e",
                          ),
                        ),
                      );
                    }
                  },

                  child: const Text(
                    "CONTINUAR",
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
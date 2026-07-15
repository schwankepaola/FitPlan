import 'package:flutter/material.dart';

// Tela exibida quando o plano de treino é criado com sucesso.
class WorkoutAssignmentCompleteScreen extends StatelessWidget {
  const WorkoutAssignmentCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Ícone indicando que a operação foi concluída com sucesso.
              const Icon(
                Icons.check_circle,
                color: Color(0xFFC6FF00),
                size: 80,
              ),

              const SizedBox(height: 20),

              const Text(
                "Plano criado com sucesso!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              const Text(
                "Seu treino foi gerado e salvo.",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Botão que leva o usuário para a tela inicial do aplicativo.
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC6FF00),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {

                    // Remove as telas anteriores e abre a Home.
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  },
                  child: const Text("Ir para Home"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
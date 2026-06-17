import 'package:flutter/material.dart';

class WorkoutAssignmentCompleteScreen extends StatelessWidget {
  const WorkoutAssignmentCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Icon(
                Icons.check_circle,
                size: 120,
                color: Colors.green,
              ),

              const SizedBox(height: 30),

              const Text(
                "Plano Criado!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "Seu plano de treino foi configurado com sucesso.",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      '/home',
                    );
                  },
                  child: const Text("IR PARA HOME"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
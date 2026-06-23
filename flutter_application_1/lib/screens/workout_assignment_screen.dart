import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class WorkoutAssignmentScreen extends StatelessWidget {
  const WorkoutAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final workouts = [
      "Segunda - Peito e Tríceps",
      "Terça - Costas e Bíceps",
      "Quarta - Cardio",
      "Quinta - Pernas",
      "Sexta - Ombros",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Plano de Treino"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            const Text(
              "Plano Gerado",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.fitness_center,
                        color: Colors.redAccent,
                      ),
                      title: Text(workouts[index]),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // 💥 MARCA TREINO COMO FEITO
                  NotificationService.markWorkoutDone();

                  // vai para tela de conclusão
                  Navigator.pushNamed(
                    context,
                    '/workout_done',
                  );
                },
                child: const Text(
                  "FINALIZAR",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
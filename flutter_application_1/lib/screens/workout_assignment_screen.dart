import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class WorkoutAssignmentScreen extends StatelessWidget {
  const WorkoutAssignmentScreen({super.key});

  List<String> gerarTreino(int dias) {
    final treinos = [
      "Peito e Tríceps",
      "Costas e Bíceps",
      "Pernas",
      "Ombros",
      "Cardio",
      "Abdômen",
      "Full Body",
    ];

    return treinos.take(dias).toList();
  }

  @override
  Widget build(BuildContext context) {
     final args = ModalRoute.of(context)!.settings.arguments;
      final int dias = (args is int) ? args : 3;
    final listaTreinos = gerarTreino(dias);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Seu plano de treino"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Treino gerado",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: listaTreinos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.fitness_center),
                    title: Text(listaTreinos[index]),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  NotificationService.markWorkoutDone();

                  Navigator.pushNamed(context, '/workout_done');
                },
                child: const Text("Finalizar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildContext {
}

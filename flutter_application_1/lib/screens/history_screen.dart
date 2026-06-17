import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = [
      "Peito e Tríceps - Concluído",
      "Costas e Bíceps - Concluído",
      "Cardio - Concluído",
      "Pernas - Concluído",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Histórico"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              title: Text(history[index]),
            ),
          );
        },
      ),
    );
  }
}
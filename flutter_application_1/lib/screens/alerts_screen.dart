import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alertas"),
      ),
      body: ListView(
        children: const [

          ListTile(
            leading: Icon(
              Icons.notifications,
              color: Colors.orange,
            ),
            title: Text("Treino às 18:00"),
            subtitle: Text("Não esqueça seu treino hoje."),
          ),

          Divider(),

          ListTile(
            leading: Icon(
              Icons.fitness_center,
              color: Colors.redAccent,
            ),
            title: Text("Meta semanal"),
            subtitle: Text("Você completou 80% da meta."),
          ),
        ],
      ),
    );
  }
}
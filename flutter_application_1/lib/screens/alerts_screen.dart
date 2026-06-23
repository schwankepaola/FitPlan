import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Alertas"),
      ),
      body: const Center(
        child: Text(
          "Nenhum alerta no momento",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

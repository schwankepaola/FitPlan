import 'package:flutter/material.dart';

class ObjectiveScreen extends StatelessWidget {
  const ObjectiveScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Objetivo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            const Text(
              'Qual é seu objetivo?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            objectiveCard(
              context,
              'Ganhar Massa Muscular',
              Icons.fitness_center,
            ),

            objectiveCard(
              context,
              'Emagrecer',
              Icons.local_fire_department,
            ),

            objectiveCard(
              context,
              'Condicionamento',
              Icons.directions_run,
            ),
          ],
        ),
      ),
    );
  }

  Widget objectiveCard(
      BuildContext context,
      String title,
      IconData icon,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.redAccent,
        ),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.pushNamed(context, '/days');
        },
      ),
    );
  }
}
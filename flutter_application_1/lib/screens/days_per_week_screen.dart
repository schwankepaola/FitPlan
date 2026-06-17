import 'package:flutter/material.dart';

class DaysPerWeekScreen extends StatefulWidget {
  const DaysPerWeekScreen({super.key});

  @override
  State<DaysPerWeekScreen> createState() => _DaysPerWeekScreenState();
}

class _DaysPerWeekScreenState extends State<DaysPerWeekScreen> {

  int selectedDays = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dias de Treino"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            const Text(
              "Quantos dias por semana você pretende treinar?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            DropdownButton<int>(
              value: selectedDays,
              isExpanded: true,
              items: List.generate(
                7,
                (index) => DropdownMenuItem(
                  value: index + 1,
                  child: Text("${index + 1} dias"),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedDays = value!;
                });
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/workout');
                },
                child: const Text(
                  "CONTINUAR",
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
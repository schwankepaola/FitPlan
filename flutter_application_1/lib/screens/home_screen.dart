import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'HOME FUNCIONANDO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                NotificationService.showTestNotification();
              },
              child: const Text("Testar notificação"),
            ),
          ],
        ),
      ),
    );
  }
}
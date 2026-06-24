import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {

  bool notificationsEnabled =
      NotificationService.notificationsEnabled ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Notificações",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              "Configurações de notificações",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Container(
              decoration: BoxDecoration(
                color: const Color(0xff111111),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: SwitchListTile(
                title: const Text(
                  "Receber notificações",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  "Lembretes diários de treino",
                  style: TextStyle(color: Colors.grey),
                ),
                value: notificationsEnabled,
                activeColor: const Color(0xFFC6FF00),
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled = value;
                  });

                  NotificationService.setNotificationsEnabled(value);

                  if (value) {
                    NotificationService.scheduleDailyReminder();
                  }
                },
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xff111111),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                "Quando ativado, você receberá lembretes diários para não esquecer seus treinos.",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

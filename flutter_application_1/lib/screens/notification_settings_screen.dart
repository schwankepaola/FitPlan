import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {

  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notificações"),
      ),
      body: SwitchListTile(
        title: const Text(
          "Receber notificações",
        ),
        subtitle: const Text(
          "Lembretes de treino",
        ),
        value: notificationsEnabled,
        onChanged: (value) {
          setState(() {
            notificationsEnabled = value;
          });
        },
      ),
    );
  }
}
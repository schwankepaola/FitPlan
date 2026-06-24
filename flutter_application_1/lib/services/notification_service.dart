import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // 📌 controle simples de treino do dia
  static DateTime? _lastWorkoutDate;

  static bool? get notificationsEnabled => null;

  static Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidInit,
    );

    await _notifications.initialize(initSettings);
  }

  // 🔥 TESTE
  static Future<void> showTestNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'test_channel',
      'Testes',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      0,
      'FitPlan 💪',
      'Notificação funcionando!',
      details,
    );
  }

  // 🔥 BOAS-VINDAS
  static Future<void> showWelcomeNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'welcome_channel',
      'Boas-vindas',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      1,
      'Bem-vinda ao FitPlan 👋',
      'Vamos começar seu treino hoje!',
      details,
    );
  }

  // 📌 MARCAR TREINO COMO FEITO
  static void markWorkoutDone() {
    _lastWorkoutDate = DateTime.now();
  }

  // 🧠 NOTIFICAÇÃO INTELIGENTE
  static Future<void> smartDailyReminder() async {
    final now = DateTime.now();

    final didWorkoutToday = _lastWorkoutDate != null &&
        _lastWorkoutDate!.year == now.year &&
        _lastWorkoutDate!.month == now.month &&
        _lastWorkoutDate!.day == now.day;

    if (didWorkoutToday) {
      return; // já treinou → não notifica
    }

    const androidDetails = AndroidNotificationDetails(
      'smart_channel',
      'Lembrete Inteligente',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      99,
      'FitPlan 💪',
      'Você ainda não treinou hoje!',
      details,
    );
  }

  // 🔥 DIÁRIA (se quiser usar depois)
  static Future<void> showDailyReminder() async {
    const androidDetails = AndroidNotificationDetails(
      'daily_channel',
      'Lembretes diários',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.periodicallyShow(
      2,
      'Hora do treino 💪',
      'Não esqueça seu treino de hoje!',
      RepeatInterval.daily,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static void setNotificationsEnabled(bool value) {}

  static void scheduleDailyReminder() {}
}
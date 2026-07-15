import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Classe responsável por gerenciar as notificações do aplicativo.
class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // Armazena a data do último treino realizado.
  static DateTime? _lastWorkoutDate;

  // Indica se as notificações estão ativadas.
  static bool _notificationsEnabled = false;

  static bool get notificationsEnabled => _notificationsEnabled;

  // Inicializa o sistema de notificações.
  static Future<void> init() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const WindowsInitializationSettings windowsInit =
        WindowsInitializationSettings(
          appName: 'FitPlan',
          appUserModelId: 'com.fitplan.app',
          guid: 'd8b7f8c0-1234-4567-8901-abcdef123456',
        );

    const InitializationSettings settings =
        InitializationSettings(
          android: androidInit,
          windows: windowsInit,
        );

    await _notifications.initialize(settings);

    // Solicita permissão para enviar notificações.
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // Envia uma notificação de teste.
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

  // Envia uma notificação de boas-vindas.
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

  // Registra que o usuário concluiu o treino do dia.
  static void markWorkoutDone() {
    _lastWorkoutDate = DateTime.now();
  }

  // Envia um lembrete apenas se o treino ainda não foi realizado hoje.
  static Future<void> smartDailyReminder() async {
    final now = DateTime.now();

    final didWorkoutToday = _lastWorkoutDate != null &&
        _lastWorkoutDate!.year == now.year &&
        _lastWorkoutDate!.month == now.month &&
        _lastWorkoutDate!.day == now.day;

    if (didWorkoutToday) {
      return;
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

  // Envia um lembrete diário com uma mensagem motivacional.
  static Future<void> showDailyReminder() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'daily_channel',
      'Lembretes de treino',
      channelDescription: 'Lembretes diários do FitPlan',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details =
        NotificationDetails(
      android: androidDetails,
    );

    final mensagens = [
      "💪 Seu treino de hoje está esperando por você!",
      "🔥 Bora manter a sequência! Não falte hoje.",
      "🏋️ Cinco minutos já fazem diferença.",
      "🚀 Seu objetivo está cada vez mais perto.",
      "❤️ Seu corpo agradece. Hora do treino!",
      "👊 Vamos manter a consistência.",
      "⭐ Não quebre sua sequência hoje.",
    ];

    // Seleciona uma mensagem diferente a cada dia.
    final indice = DateTime.now().day % mensagens.length;

    await _notifications.show(
      10,
      "FITPLAN",
      mensagens[indice],
      details,
    );
  }

  // Ativa ou desativa as notificações.
  static Future<void> setNotificationsEnabled(bool value) async {
    _notificationsEnabled = value;

    if (value) {
      await showDailyReminder();
    } else {
      await _notifications.cancelAll();
    }
  }

  // Agenda o lembrete diário caso as notificações estejam ativadas.
  static Future<void> scheduleDailyReminder() async {
    if (!_notificationsEnabled) return;

    await showDailyReminder();
  }
}
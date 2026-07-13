import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // 📌 controle simples de treino do dia
  static DateTime? _lastWorkoutDate;

  static bool _notificationsEnabled = false;

static bool get notificationsEnabled => _notificationsEnabled;
 static Future<void> init() async {
  const AndroidInitializationSettings androidInit =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings settings =
      InitializationSettings(
    android: androidInit,
  );

  await _notifications.initialize(settings);

  await _notifications
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
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

  final indice =
      DateTime.now().day % mensagens.length;

  await _notifications.show(
    10,
    "FITPLAN",
    mensagens[indice],
    details,
  );
}
static Future<void> setNotificationsEnabled(bool value) async {
  _notificationsEnabled = value;

  if (value) {
    await showDailyReminder();
  } else {
    await _notifications.cancelAll();
  }
}

static Future<void> scheduleDailyReminder() async {
  if (!_notificationsEnabled) return;

  await showDailyReminder();
}
}
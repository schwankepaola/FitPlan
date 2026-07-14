import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/objective_screen.dart';
import 'screens/user_data_screen.dart';
import 'screens/days_per_week_screen.dart';
import 'screens/workout_assignment_screen.dart';
import 'screens/workout_assignment_complete_screen.dart';
import 'screens/history_screen.dart';
import 'screens/alerts_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/notification_settings_screen.dart';
import 'screens/days_assignment_screen.dart';

import 'theme/app_theme.dart';
import 'services/notification_service.dart';
import 'dart:io';

void main() async {
  // Garante que o Flutter esteja totalmente inicializado
  // antes de executar qualquer código assíncrono.
  WidgetsFlutterBinding.ensureInitialized();

  // Configura o banco de dados de acordo com a plataforma.
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  } else if (Platform.isWindows ||
      Platform.isLinux ||
      Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Inicializa o serviço de notificações locais.
  await NotificationService.init();

  // Inicia a aplicação.
  runApp(const FitPlanApp());
}

// Classe principal da aplicação.
class FitPlanApp extends StatelessWidget {
  const FitPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove a faixa "Debug" do canto da tela.
      debugShowCheckedModeBanner: false,

      // Nome da aplicação.
      title: 'FITPLAN',

      // Tema utilizado em todas as telas.
      theme: AppTheme.darkTheme,

      // Primeira tela exibida ao iniciar o aplicativo.
      initialRoute: '/login',

      // Rotas de navegação entre as telas.
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),

        // Fluxo principal de cadastro do usuário
        '/objective': (context) => const ObjectiveScreen(),
        '/user_data': (context) => const UserDataScreen(),
        '/days': (context) => const DaysPerWeekScreen(),
        '/assign_days': (context) => const DaysAssignmentScreen(),

        '/workout': (context) => const WorkoutAssignmentScreen(),
        '/workout_done': (context) =>
            const WorkoutAssignmentCompleteScreen(),

        // Telas principais do aplicativo
        '/home': (context) => const HomeScreen(),
        '/history': (context) => const HistoryScreen(),
        '/alerts': (context) => const AlertsScreen(),
        '/profile': (context) => const ProfileScreen(),

        // Tela de configuração das notificações
        '/notifications': (context) =>
            const NotificationSettingsScreen(),
      },
    );
  }
}
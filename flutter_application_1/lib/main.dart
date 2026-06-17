import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/objective_screen.dart';
import 'screens/days_per_week_screen.dart';
import 'screens/workout_assignment_screen.dart';
import 'screens/workout_assignment_complete_screen.dart';
import 'screens/history_screen.dart';
import 'screens/alerts_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/notification_settings_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const FitPlanApp());
}

class FitPlanApp extends StatelessWidget {
  const FitPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FITPLAN',
      theme: AppTheme.darkTheme,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/objective': (context) => const ObjectiveScreen(),
        '/days': (context) => const DaysPerWeekScreen(),
        '/workout': (context) => const WorkoutAssignmentScreen(),
        '/workout_done': (context) => const WorkoutAssignmentCompleteScreen(),
        '/home': (context) => const HomeScreen(),
        '/history': (context) => const HistoryScreen(),
        '/alerts': (context) => const AlertsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/notifications': (context) => const NotificationSettingsScreen(),
      },
    );
  }
}
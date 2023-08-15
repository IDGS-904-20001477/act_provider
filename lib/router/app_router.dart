import 'package:act_provider/screen/screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Map<String, Widget Function(BuildContext context)> routes = {
    '/': (BuildContext context) => const CheckSessionScreen(),
    '/LoginScreen': (BuildContext context) => const LoginScreen(),
    '/HomeScreen': (BuildContext context) => const HomeScreen()
  };

  static String initialRoute = '/';

  static onGenerateRouter(settings) {
    return MaterialPageRoute(builder: (context) => const ErrorScreen());
  }
}

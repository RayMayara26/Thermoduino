import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/reset_password_screen.dart';
import 'screens/auth/home_screen.dart';
import 'screens/auth/records_screen.dart';
import 'screens/auth/account_screen.dart';

void main() {
  runApp(const ThermoduinoApp());
}

class ThermoduinoApp extends StatelessWidget {
  const ThermoduinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thermoduino',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/register':
            return MaterialPageRoute(builder: (_) => const RegisterScreen());
          case '/reset':
            return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
          case '/home':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(builder: (_) => HomeScreen(userId: args['userId']));
          case '/records':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(builder: (_) => RecordsScreen(userId: args['userId']));
          case '/account':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(builder: (_) => AccountScreen(userId: args['userId']));
          default:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
        }
      },
    );
  }
}

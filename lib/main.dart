import 'package:flutter/material.dart';
import 'package:login_test/utils/theme.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Page',
      themeMode: ThemeMode.system,
      theme: TappTheme.lightTheme,
      darkTheme: TappTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
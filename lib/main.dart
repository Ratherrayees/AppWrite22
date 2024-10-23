// this is lib/main.dart
import 'package:flutter/material.dart';
import 'initializer.dart';
import 'app_theme.dart';
import 'screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gulposh Food Service',
      theme: appTheme,
      home: LoginScreen(),
    );
  }
}
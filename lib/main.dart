import 'package:flutter/material.dart';
import 'ui/home_screen.dart';

void main() {
  runApp(const OrchidApp());
}

class OrchidApp extends StatelessWidget {
  const OrchidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orchid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF8A2BE2), // Violet
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF4B0082)),
      ),
      home: const HomeScreen(),
    );
  }
}

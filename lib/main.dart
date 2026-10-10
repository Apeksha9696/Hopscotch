import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() => runApp(const HopscotchApp());

class HopscotchApp extends StatelessWidget {
  const HopscotchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hopscotch Homepage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFE53935),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}

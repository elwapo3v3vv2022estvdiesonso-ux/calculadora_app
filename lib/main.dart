import 'package:flutter/material.dart';
import 'bienvenida.dart';

void main() {
  runApp(const MiCalculadoraApp());
}

class MiCalculadoraApp extends StatelessWidget {
  const MiCalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de Porcentajes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // <--- Importa Hive
import 'bienvenida.dart';

void main() async {
  // Aseguramos que los widgets estén ligados antes de inicializar servicios nativos
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializamos Hive para Flutter
  await Hive.initFlutter();

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
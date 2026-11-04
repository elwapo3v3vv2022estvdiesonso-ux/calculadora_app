import 'package:flutter/material.dart';

class CalculadoraPorcentajeScreen extends StatefulWidget {
  const CalculadoraPorcentajeScreen({super.key});

  @override
  State<CalculadoraPorcentajeScreen> createState() =>
      _CalculadoraPorcentajeScreenState();
}

class _CalculadoraPorcentajeScreenState
    extends State<CalculadoraPorcentajeScreen> {
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _porcentajeController = TextEditingController();

  double? _resultado;

  void _calcularPorcentaje() {
    final double? numero = double.tryParse(_numeroController.text);
    final double? porcentaje = double.tryParse(_porcentajeController.text);

    setState(() {
      if (numero != null && porcentaje != null) {
        _resultado = (numero * porcentaje) / 100;
      } else {
        _resultado = null;
      }
    });
  }

  @override
  void dispose() {
    _numeroController.dispose();
    _porcentajeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Margen superior para dar espacio al logo de la imagen de fondo
                const SizedBox(height: 120),

                const Text(
                  'Calculadora de Porcentajes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),

                // Campo 1: Número principal
                TextField(
                  controller: _numeroController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Número principal',
                    labelStyle: const TextStyle(color: Colors.white70),
                    hintText: 'Ej. 250',
                    hintStyle: const TextStyle(color: Colors.white38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.cyanAccent),
                    ),
                    prefixIcon: const Icon(Icons.numbers, color: Colors.cyanAccent),
                    filled: true,
                    fillColor: const Color(0xFF0F172A).withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 20),

                // Campo 2: Porcentaje a calcular
                TextField(
                  controller: _porcentajeController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Porcentaje a calcular (%)',
                    labelStyle: const TextStyle(color: Colors.white70),
                    hintText: 'Ej. 15',
                    hintStyle: const TextStyle(color: Colors.white38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.cyanAccent),
                    ),
                    prefixIcon: const Icon(Icons.percent, color: Colors.cyanAccent),
                    filled: true,
                    fillColor: const Color(0xFF0F172A).withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 24),

                // Botón de calcular
                ElevatedButton(
                  onPressed: _calcularPorcentaje,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Calcular',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Tarjeta de Resultado
                Card(
                  elevation: 6,
                  color: const Color(0xFF0F172A).withOpacity(0.85),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Colors.cyanAccent, width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        const Text(
                          'Resultado',
                          style: TextStyle(fontSize: 18, color: Colors.white70),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _resultado != null
                              ? _resultado!.toStringAsFixed(2)
                              : '0.00',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
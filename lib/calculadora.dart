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
  
  // Lista local para almacenar el historial de cálculos
  final List<String> _historial = [];

  void _calcularPorcentaje() {
    final double? numero = double.tryParse(_numeroController.text);
    final double? porcentaje = double.tryParse(_porcentajeController.text);

    setState(() {
      if (numero != null && porcentaje != null) {
        _resultado = (numero * porcentaje) / 100;
        
        // Formamos el texto del cálculo realizado
        String registro = '$porcentaje% de $numero = ${_resultado!.toStringAsFixed(2)}';
        
        // Evitamos duplicar exactamente el último registro si es idéntico
        if (_historial.isEmpty || _historial.first != registro) {
          _historial.insert(0, registro); // Inserta el más reciente arriba
        }
      } else {
        _resultado = null;
      }
    });
  }

  // Función para limpiar el historial
  void _limpiarHistorial() {
    setState(() {
      _historial.clear();
      _resultado = null;
      _numeroController.clear();
      _porcentajeController.clear();
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
                // Espacio superior para el logo del fondo
                const SizedBox(height: 160),

                const Text(
                  'Calculadora de Porcentajes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),

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
                  onChanged: (_) => _calcularPorcentaje(),
                ),
                const SizedBox(height: 16),

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
                  onChanged: (_) => _calcularPorcentaje(),
                ),
                const SizedBox(height: 20),

                // Tarjeta de Resultado Actual
                Card(
                  elevation: 6,
                  color: const Color(0xFF0F172A).withOpacity(0.85),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Colors.cyanAccent, width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text(
                          'Resultado',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _resultado != null
                              ? _resultado!.toStringAsFixed(2)
                              : '0.00',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Sección del Historial
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Historial de cálculos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (_historial.isNotEmpty)
                      TextButton.icon(
                        onPressed: _limpiarHistorial,
                        icon: const Icon(Icons.delete_sweep, color: Colors.redAccent, size: 20),
                        label: const Text(
                          'Limpiar',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),

                // Contenedor dinámico del historial con scroll seguro
                _historial.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          'No hay cálculos recientes',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white54, fontStyle: FontStyle.italic),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true, // Se adapta al contenido dentro del SingleChildScrollView
                        physics: const NeverScrollableScrollPhysics(), // Evita conflictos de scroll
                        itemCount: _historial.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0F172A).withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.history, color: Colors.cyanAccent, size: 18),
                                const SizedBox(width: 12),
                                Expanded(
                                 child: Text(
                                    _historial[index],
                                    style: const TextStyle(color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
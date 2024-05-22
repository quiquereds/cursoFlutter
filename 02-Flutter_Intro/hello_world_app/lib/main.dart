import 'package:flutter/material.dart';
import 'package:hello_world_app/presentation/screens/counter/counter_functions_screen.dart';

// Función principal
void main() {
  // Retornamos el widget inicial
  runApp(const MyApp());
}

// Widget inicial
class MyApp extends StatelessWidget {
  // Inicialización
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Devolvemos widget hijo
    return MaterialApp(
      theme: ThemeData(
        // Crea paleta de colores a partir de un color
        colorSchemeSeed: Colors.green,
      ),
      // Quita el banner de debug en el UI de la app
      debugShowCheckedModeBanner: false,
      // Define la vista home de la aplicación
      home: const CounterFunctionsScreen(),
    );
  }
}

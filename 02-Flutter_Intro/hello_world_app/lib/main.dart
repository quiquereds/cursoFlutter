import 'package:flutter/material.dart';

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
    return const Placeholder(
      child: MaterialApp(
        // Quita el banner de debug en el UI de la app
        debugShowCheckedModeBanner: false,

        /// El Scaffold implementa un diseño básico de app y da las
        /// bases para colocar más elementos de UI
        home: Scaffold(
          /// El Center centra todo el contenido de los hijos en su
          /// espacio disponible.
          body: Center(
            child: Text('Hola Mundo'),
          ),
        ),
      ),
    );
  }
}

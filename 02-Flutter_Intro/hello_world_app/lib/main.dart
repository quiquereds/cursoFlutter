import 'package:flutter/material.dart';

// Función principal
void main() {
  // Retornamos el widget inicial
  runApp(const MyApp());
}

// Widget inicial
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Devolvemos widget hijo
    return const Placeholder(
      child: MaterialApp(
        home: Center(
          child: Text('Hola mundo'),
        ),
      ),
    );
  }
}

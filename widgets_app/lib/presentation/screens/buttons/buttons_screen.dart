import 'package:flutter/material.dart';

class ButtonsScreen extends StatelessWidget {
  /// Definimos el nombre de la ruta
  /// La palabra reservada static, sirve para no crear instancias de
  /// HomeScreen al llamar a esta propiedad.
  static const String name = 'buttons_screen';

  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons screen'),
      ),
      body: const Placeholder(),
    );
  }
}

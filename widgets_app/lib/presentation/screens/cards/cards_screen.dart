import 'package:flutter/material.dart';

class CardsScreen extends StatelessWidget {
  /// Definimos el nombre de la ruta
  /// La palabra reservada static, sirve para no crear instancias de
  /// HomeScreen al llamar a esta propiedad.
  static const String name = 'cards_screen';

  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards screen'),
      ),
      body: const Placeholder(),
    );
  }
}

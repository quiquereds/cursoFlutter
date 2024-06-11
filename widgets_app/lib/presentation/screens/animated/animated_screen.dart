import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedScreen extends StatefulWidget {
  static const name = 'animated_screen';

  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {
  // Creamos controladores de la animación
  double width = 50;
  double height = 50;
  Color color = Colors.indigo;
  double borderRadius = 10.0;

  // Creamos un método que se encargará de transformar las propiedades
  void changeShape() {
    // Creamos una instancia de Math Random
    final random = Random();

    width = random.nextInt(400) + 120;
    height = random.nextInt(400) + 120;
    borderRadius = random.nextInt(100) * 20;
    color = Color.fromRGBO(
      1 + random.nextInt(255), // Rojo
      1 + random.nextInt(255), // Verde
      1 + random.nextInt(255), // Azul
      1, // Opacidad
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Container'),
      ),
      body: Center(
        /// Crea un widget animado que se transforma al realizar cualquier
        /// modificación a sus propiedades físicas
        child: AnimatedContainer(
          width: width <= 0 ? 0 : width,
          height: height <= 0 ? 0 : height,
          // Tipo de velocidad o curva de la animación
          curve: Curves.easeOutCubic,
          // Duración de la animación
          duration: const Duration(milliseconds: 400),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(borderRadius <= 0 ? 0 : borderRadius),
            color: color,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeShape,
        child: const Icon(Icons.play_arrow_outlined),
      ),
    );
  }
}

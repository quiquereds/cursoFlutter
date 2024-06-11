import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  static const name = 'progress_screen';

  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Indicators'),
      ),
      body: _ProgressView(),
    );
  }
}

class _ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Text('Circular progress indicator'),
          const SizedBox(height: 20),
          const CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: Colors.black26,
          ),
          const SizedBox(height: 30),
          const Text('Progress indicator controlado'),
          const SizedBox(height: 20),
          _ControllerProgressIndicator(),
        ],
      ),
    );
  }
}

class _ControllerProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Creamos un Stream
    return StreamBuilder(
      /// El stream va a estar devolviendo valores de 0 a 1.0 (para
      /// representar el porcentaje de carga)
      stream: Stream.periodic(
        const Duration(milliseconds: 300),
        (value) {
          return (value * 2) / 100; // -> 0.0 - 1.0
        },

        /// Cuando el valor llegue a 100, el takeWhile se encargará de
        /// cancelar la suscripción al Stream
      ).takeWhile((value) => value < 100),
      builder: (context, snapshot) {
        /// Creamos una variable que va a extraer los datos del stream (
        /// el porcentaje de carga) para reflejarlos en el indicador de
        /// progreso
        final progressValue = snapshot.data ?? 0;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                value: progressValue,
                strokeWidth: 2,
                backgroundColor: Colors.black12,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: LinearProgressIndicator(
                  value: progressValue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

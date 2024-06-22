import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  // Creamos un Stream que va a devolver Strings cada 1200 milisegundos
  Stream<String> getLoadingMessages() {
    // Creamos una lista de mensajes
    final List<String> messages = [
      'Cargando películas',
      'Comprando palomitas',
      'Cargando populares',
      'Llamando a mi novia',
      'Ya mero',
      'Esto está tardando más de lo esperado',
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espera por favor'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          // Creamos un StreamBuilder que va a renderizar los eventos del stream
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Cargando...');

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}

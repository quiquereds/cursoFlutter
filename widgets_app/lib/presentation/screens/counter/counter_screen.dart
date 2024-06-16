import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/counter_provider.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

/// Reemplazamos el stl widget con un ConsumerWidget, que permitirá darnos
/// una referencia hacia los providers de Riverpod
class CounterScreen extends ConsumerWidget {
  static const String name = 'counter_screen';

  const CounterScreen({super.key});

  @override
  // Añadimos como parámetro el WidgetRef para indicarle a Riverpod que
  // se necesita la referencia a algún provider
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtenemos el tema de la aplicación
    final textStyleTheme = Theme.of(context).textTheme;

    // Creamos la referencia al counterProvider
    final int counterValue = ref.watch(counterProvider);

    // Creamos la referencia al tema de la aplicación
    final bool isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            ),
            onPressed: () {
              // Escuchamos el cambio al cambiar el estado al tema
              ref.read(isDarkModeProvider.notifier).update((state) => !state);
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Valor: $counterValue',
          style: textStyleTheme.titleLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Escuchamos el cambio al sumar 1 al estado de counterProvider
          ref.read(counterProvider.notifier).state++;
        },
        child: const Icon(Icons.plus_one_rounded),
      ),
    );
  }
}

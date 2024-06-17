import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

class ThemeChangerScreen extends ConsumerWidget {
  static const String name = 'theme_changer_screen';

  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Creamos la referencia al tema de la aplicación
    final bool isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Changer'),
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
      body: const _ThemeChangerView(),
    );
  }
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuchamos el provider del listado de colores disponible
    final List<Color> colors = ref.watch(colorListProvider);

    // Escuchamos el provider del color seleccionado del tema
    final int selectedColor = ref.watch(selectedColorProvider);

    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final Color color = colors[index];

        return RadioListTile(
          title: Text(
            'Este color',
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(color.value.toString()),
          // Color del bullet
          activeColor: color,
          // Valor de cada RadioListTile
          value: index,
          // Valor seleccionado
          groupValue: selectedColor,
          // Notificamos el cambio al provider
          onChanged: (newValue) {
            ref.read(selectedColorProvider.notifier).state = newValue!;
          },
        );
      },
    );
  }
}

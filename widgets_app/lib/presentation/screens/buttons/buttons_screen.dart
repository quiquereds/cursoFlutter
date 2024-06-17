import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      body: _ButtonsView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          // Quitamos la vista de ButtonsScreen del stack (volvemos atrás)
          context.pop();
        },
      ),
    );
  }
}

class _ButtonsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          children: [
            // Botón habilitado
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated'),
            ),

            // Botón deshabilitado
            const ElevatedButton(
              onPressed: null,
              child: Text('Disabled'),
            ),

            // Botón con ícono
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.alarm_add_outlined),
              label: const Text('Elevated icon'),
            ),

            // Botón con relleno
            FilledButton(
              onPressed: () {},
              child: const Text('Filled'),
            ),

            // Botón con relleno e ícono
            FilledButton.icon(
              onPressed: () {},
              label: const Text('Filled icon'),
              icon: const Icon(Icons.account_balance_sharp),
            ),

            // Botón con borde
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined'),
            ),

            // Botón con borde e ícono
            OutlinedButton.icon(
              onPressed: () {},
              label: const Text('Outlined icon'),
              icon: const Icon(Icons.accessibility_sharp),
            ),

            // Botón de texto
            TextButton(
              onPressed: () {},
              child: const Text('Text Button'),
            ),

            // Botón de texto con icono
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.abc),
              label: const Text('Text button icon'),
            ),

            // TODO: Custom Button

            // Botón de ícono
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sunny),
            ),

            // Botón de ícono con estilo
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sunny, color: Colors.white),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(colors.primary),
              ),
            ),

            // Botón personalizado
            const CustomButton(),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Utilizamos este widget para crear bordes redondeados
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),

      /// Utilizamos el Inkwell envuelto con Material para replicar el efecto
      /// splash de un botón convencional
      child: Material(
        color: colors.primary,
        child: InkWell(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Custom Button',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

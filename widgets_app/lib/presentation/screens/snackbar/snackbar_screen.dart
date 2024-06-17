import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {
  static const name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  // Creamos un método para regresar un Snackbar personalizado
  void showCustomSnackbar(BuildContext context) {
    // Limpiamos los snackbars anteriores
    ScaffoldMessenger.of(context).clearSnackBars();

    // Creamos un Snackbar
    SnackBar snackbar = SnackBar(
      content: const Text('Hola Mundo'),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    );

    // Mostramos el snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  // Creamos un método para devolver un diálogo
  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      // Obligamos que el diálogo no se pueda cerrar al pulsar fuera de el
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Estás seguro?'),
        content: const Text(
            'Non nostrud nisi ut elit reprehenderit aliqua consectetur reprehenderit proident eu ea. Pariatur adipisicing irure nisi enim. Aute enim incididunt officia do.'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => context.pop(),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars y diálogos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () {
                showAboutDialog(
                  context: context,
                  children: [
                    const Text(
                        'Proident culpa labore Lorem quis dolor esse do occaecat. Aliqua aliquip sint ullamco sint labore id officia cupidatat duis sunt nostrud labore. Veniam eu do minim non ex cillum sit sit deserunt culpa deserunt.')
                  ],
                );
              },
              child: const Text('Ver licencias usadas'),
            ),
            FilledButton.tonal(
              onPressed: () => openDialog(context),
              child: const Text('Mostrar diálogo'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Mostrar Snackbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () {
          /// Mostramos un Snackbar al presionar el botón con el
          /// ScaffoldMessenger
          showCustomSnackbar(context);
        },
      ),
    );
  }
}

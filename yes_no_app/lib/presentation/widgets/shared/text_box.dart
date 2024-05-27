import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  const TextBox({super.key});

  @override
  Widget build(BuildContext context) {
    // Recuperamos el color
    final ColorScheme colors = Theme.of(context).colorScheme;

    // Creamos una variable para reutilizarla en el tema del TextFormField
    final InputBorder outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    // Creamos una variable para almacenar toda la decoración
    final formInputDecoration = InputDecoration(
      // Estilo del campo
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder.copyWith(
        borderSide: BorderSide(color: colors.primary),
      ),
      // Relleno de color del campo
      filled: true,
      // Widget de sufijo de botón de icono
      suffixIcon: IconButton(
        icon: const Icon(Icons.send_outlined),
        onPressed: () {
          // TODO: Recuperar el valor enviado
          print('Boton presionado, valor: ?');
        },
      ),
    );

    // Widget de formulario de texto de Flutter
    return TextFormField(
      decoration: formInputDecoration,
      // Mostramos en consola cada tecla que se presiona
      onChanged: (value) {
        print('Changed: $value');
      },
      onFieldSubmitted: (value) {
        // Mostramos en consola el valor enviado
        print('value: $value');
      },
    );
  }
}

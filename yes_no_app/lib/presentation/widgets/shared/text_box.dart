import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  /// ValueChanged nos da la flexibilidad de no amarrar el widget a que
  /// solo funcione con Provider
  final ValueChanged<String> onValue;

  const TextBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {
    // Creamos un controlador Focus Node
    final FocusNode focusNode = FocusNode();

    // Creamos un controlador de la caja de texto
    final TextEditingController textController = TextEditingController();

    // Recuperamos el color
    final ColorScheme colors = Theme.of(context).colorScheme;

    // Creamos una variable para reutilizarla en el tema del TextFormField
    final InputBorder outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    // Creamos una variable para almacenar toda la decoración
    final formInputDecoration = InputDecoration(
      // Pista del formulario
      hintText: 'End your message with a \'?\'',

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
          // Obtenemos el texto
          final textValue = textController.value.text;
          // Limpiamos el controller
          textController.clear();
          // Mandamos a llamar a la función con el textValue
          onValue(textValue);
        },
      ),
    );

    // Widget de formulario de texto de Flutter
    return TextFormField(
      focusNode: focusNode,
      // Asignamos el controlador del formulario
      controller: textController,
      // Asignamos la decoración establecida previamente
      decoration: formInputDecoration,
      // Propiedades del teclado
      keyboardType: TextInputType.text,
      // Función de envío del formulario
      onFieldSubmitted: (value) {
        // Limpiamos el controller
        textController.clear();

        /// Mantenemos el foco para brindar mensajes continuos
        /// (el teclado va a permanecer abierto)
        focusNode.requestFocus();
        // Emitimos el value al padre
        onValue(value);
      },
      // Función al presionar fuera del formulario
      onTapOutside: (event) {
        // Llamamos al focusNode para salir del teclado
        focusNode.unfocus();
      },
    );
  }
}

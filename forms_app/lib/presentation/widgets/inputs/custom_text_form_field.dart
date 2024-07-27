import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  // Solicitamos atributos para personalizar el widget
  final String? label;
  final String? hint;
  final String? errorMessage;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? icon;
  final bool obscureText;

  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    // Referencia a colores de la app
    final colors = Theme.of(context).colorScheme;

    // Outline border personalizado
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      //borderSide: BorderSide(color: colors.primary),
    );

    /// Tipo de campo de texto asociado a un widget Form que presenta
    /// más características de control y validación que un campo normal
    /// (TextField)
    return TextFormField(
      // Se llama a una función cada que hay un cambio en la caja de texto
      onChanged: onChanged,

      /// Es una función que se manda a llamar con el controlador del widget
      /// Form para validar la información ingresada
      validator: validator,

      // Oculta los caracteres si su valor es true
      obscureText: obscureText,

      /// Diseño de la caja de texto
      decoration: InputDecoration(
          // Borde cuando la caja de texto está habilitada (se puede modificar)
          enabledBorder: border,
          // Borde cuando la caja de texto está activa (en edición)
          focusedBorder: border.copyWith(
            borderSide: BorderSide(color: colors.primary),
          ),
          errorBorder: border.copyWith(
            borderSide: BorderSide(color: Colors.red.shade800),
          ),
          focusedErrorBorder: border.copyWith(
            borderSide: BorderSide(color: Colors.red.shade800),
          ),

          /// Valor booleano que compacta el campo de texto
          isDense: true,

          // Indicador del valor que se tiene que ingresar
          label: label != null ? Text(label!) : null,

          // Pista de un posible valor aceptado
          hintText: hint,

          // Color del cursor de texto y selectores
          focusColor: colors.primary,

          // Icono izquierdo de la caja de texto
          prefixIcon: prefixIcon,

          // Icono situado fuera de la caja
          icon: icon,

          // Icono derecho de la caja de texto
          suffixIcon: suffixIcon,

          // Texto de error, si tiene valor, activa el diseño de error
          errorText: errorMessage // =! 'Esto es un error',
          ),
    );
  }
}

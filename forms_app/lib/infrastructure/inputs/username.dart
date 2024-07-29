import 'package:formz/formz.dart';

// Definimos tipos de errores de validación de datos
enum UsernameError { empty, length }

/// Creamos un nuevo tipo de dato llamado Username extendiendo
/// a un FormzInput que nos va a ayudar a abstraer la lógica de
/// validaciones en un formulario, de tal forma que se pueda
/// reutilizar la validación en otros lugares de la aplicación
class Username extends FormzInput<String, UsernameError> {
  /// Creamos el constructor definiendo el super para establecer un
  /// valor inicial.
  const Username.pure() : super.pure('');

  // Llamamos a super.dirty para indicar cambios en el valor.
  // Este método se manda a llamar cuando el campo es alterado por el usuario
  const Username.dirty(super.value) : super.dirty();

  // Getter para obtener el mensaje de error (si hay)
  String? get errrorMessage {
    if (isValid || isPure) return null;
    if (displayError == UsernameError.empty) return 'El campo es requerido';
    if (displayError == UsernameError.length) return 'Mínimo 6 caracteres';
    return null;
  }

  // Sobreescribimos un método validator para realizar las validaciones del valor
  @override
  UsernameError? validator(String value) {
    // Validamos si el valor es vacío o menor de 6 caracteres
    if (value.isEmpty || value.trim().isEmpty) return UsernameError.empty;
    if (value.length < 6) return UsernameError.length;

    // Retornamos null si pasa todas las condiciones.
    return null;
  }
}

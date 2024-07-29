import 'package:formz/formz.dart';

// Definimos tipos de errores de validación de datos
enum PasswordError { empty, length }

/// Creamos un nuevo tipo de dato llamado Username extendiendo
/// a un FormzInput que nos va a ayudar a abstraer la lógica de
/// validaciones en un formulario, de tal forma que se pueda
/// reutilizar la validación en otros lugares de la aplicación
class Password extends FormzInput<String, PasswordError> {
  /// Creamos el constructor definiendo el super para establecer un
  /// valor inicial.
  const Password.pure() : super.pure('');

  // Llamamos a super.dirty para indicar cambios en el valor.
  // Este método se manda a llamar cuando el campo es alterado por el usuario
  const Password.dirty(super.value) : super.dirty();

  // Getter para obtener el mensaje de error (si hay)
  String? get errrorMessage {
    if (isValid || isPure) return null;
    if (displayError == PasswordError.empty) return 'El campo es requerido';
    if (displayError == PasswordError.length) return 'Mínimo 6 caracteres';
    return null;
  }

  // Sobreescribimos un método validator para realizar las validaciones del valor
  @override
  PasswordError? validator(String value) {
    // Validamos si el valor es vacío o menor de 6 caracteres
    if (value.isEmpty || value.trim().isEmpty) return PasswordError.empty;
    if (value.length < 6) return PasswordError.length;

    // Retornamos null si pasa todas las condiciones.
    return null;
  }
}

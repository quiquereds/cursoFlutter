// Definimos tipos de errores de validación de datos
import 'package:formz/formz.dart';

enum EmailError { empty, invalid }

/// Creamos un nuevo tipo de dato llamado Username extendiendo
/// a un FormzInput que nos va a ayudar a abstraer la lógica de
/// validaciones en un formulario, de tal forma que se pueda
/// reutilizar la validación en otros lugares de la aplicación
class Email extends FormzInput<String, EmailError> {
  // Método estático para acceder a la expresión regular de correo electrónico
  static final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  /// Creamos el constructor definiendo el super para establecer un
  /// valor inicial.
  const Email.pure() : super.pure('');

  // Llamamos a super.dirty para indicar cambios en el valor.
  // Este método se manda a llamar cuando el campo es alterado por el usuario
  const Email.dirty(super.value) : super.dirty();

  // Getter para obtener el mensaje de error (si hay)
  String? get errrorMessage {
    if (isValid || isPure) return null;
    if (displayError == EmailError.empty) return 'El campo es requerido';
    if (displayError == EmailError.invalid) return 'El email es inválido';
    return null;
  }

  // Sobreescribimos un método validator para realizar las validaciones del valor
  @override
  EmailError? validator(String value) {
    // Validamos si el valor es vacío o inválido
    if (value.isEmpty || value.trim().isEmpty) return EmailError.empty;
    if (!emailRegExp.hasMatch(value)) return EmailError.invalid;

    // Retornamos null si pasa todas las condiciones.
    return null;
  }
}

part of 'register_cubit.dart';

// Enumeración para determinar el estado del formulario
enum FormStatus { invalid, valid, validating, posting }

class RegisterFormState extends Equatable {
  // Atributos del RegisterForm
  final FormStatus formStatus;
  final String username;
  final String email;
  final String password;

  // Creamos el constructor con valores inicializados por defecto
  const RegisterFormState({
    this.formStatus = FormStatus.invalid,
    this.username = '',
    this.email = '',
    this.password = '',
  });

  /// Método para emitir un nuevo estado (copia del estado actual + nuevo estado)
  /// usando el helper copyWith
  copyWith({
    FormStatus? formStatus,
    String? username,
    String? email,
    String? password,
  }) =>

      /// Devolvemos un nuevo estado con los valores recibidos, en caso de ser nulos,
      /// se usan los valores del estado anterior.
      RegisterFormState(
        formStatus: formStatus ?? this.formStatus,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  List<Object> get props => [formStatus, username, email, password];
}

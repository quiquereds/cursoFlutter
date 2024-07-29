part of 'register_cubit.dart';

// Enumeración para determinar el estado del formulario
enum FormStatus { invalid, valid, validating, posting }

class RegisterFormState extends Equatable {
  // Atributos del RegisterForm
  final FormStatus formStatus;
  final Username username;
  final Email email;
  final Password password;
  final bool isValid;

  // Creamos el constructor con valores inicializados por defecto
  const RegisterFormState({
    this.formStatus = FormStatus.invalid,

    /// Usamos el tipo de dato personalizado, el método pure se encarga
    /// de inicializar el objeto con el valor inicial del constructor
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
  });

  /// Método para emitir un nuevo estado (copia del estado actual + nuevo estado)
  /// usando el helper copyWith
  copyWith({
    FormStatus? formStatus,
    Username? username,
    Email? email,
    Password? password,
    bool? isValid,
  }) =>

      /// Devolvemos un nuevo estado con los valores recibidos, en caso de ser nulos,
      /// se usan los valores del estado anterior.
      RegisterFormState(
        formStatus: formStatus ?? this.formStatus,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid,
      );

  @override
  List<Object> get props => [formStatus, username, email, password];
}

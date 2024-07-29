import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  // Método para validar el formulario
  void onSubmit() {
    /// Hacemos un cambio en el estado sobreescribiendo todas las
    /// propiedades con los valores actuales de los campos.
    emit(
      state.copyWith(
        formStatus: FormStatus.validating,
        username: Username.dirty(state.username.value),
        password: Password.dirty(state.password.value),
        email: Email.dirty(state.email.value),
        // Ejecutamos las validaciones
        isValid: Formz.validate([state.username, state.password, state.email]),
      ),
    );

    print('State: $state');
  }

  // Creamos métodos para emitir un nuevo estado cada que un campo cambie
  void usernameChanged(String value) {
    /// Usamos el método de el objeto personalizado para crear una instancia
    /// con el nuevo valor
    final username = Username.dirty(value);

    emit(
      state.copyWith(
        username: username,

        /// Mandamos a llamar al método validate de Formz para que se ejecuten
        /// todas las validaciones creadas relacionadas al input que se mande
        isValid: Formz.validate([username, state.password, state.email]),
      ),
    );
  }

  void emailChanged(String value) {
    /// Usamos el método de el objeto personalizado para crear una instancia
    /// con el nuevo valor
    final email = Email.dirty(value);

    emit(
      state.copyWith(
        email: email,

        /// Mandamos a llamar al método validate de Formz para que se ejecuten
        /// todas las validaciones creadas relacionadas al input que se mande
        isValid: Formz.validate([email, state.username, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    /// Usamos el método de el objeto personalizado para crear una instancia
    /// con el nuevo valor
    final password = Password.dirty(value);

    emit(
      state.copyWith(
        password: password,

        /// Mandamos a llamar al método validate de Formz para que se ejecuten
        /// todas las validaciones creadas relacionadas al input que se mande
        isValid: Formz.validate([password, state.username, state.email]),
      ),
    );
  }
}

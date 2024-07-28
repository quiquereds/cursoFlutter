import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  // Méotod para validar el formulario
  void onSubmit() {
    print('State: $state');
  }

  // Creamos métodos para emitir un nuevo estado cada que un campo cambie
  void usernameChanged(String value) {
    emit(
      state.copyWith(username: value),
    );
  }

  void emailChanged(String value) {
    emit(
      state.copyWith(email: value),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(password: value),
    );
  }
}

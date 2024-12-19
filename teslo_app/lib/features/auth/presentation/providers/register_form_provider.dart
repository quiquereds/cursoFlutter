import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/providers/providers.dart';
import 'package:teslo_shop/features/shared/shared.dart';

// * StateNotifierProvider
final registerFormProvider =
    StateNotifierProvider<RegisterFormNotifier, RegisterFormState>((ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;

  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});

// * State Notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String) registerUserCallback;

  RegisterFormNotifier({required this.registerUserCallback})
      : super(RegisterFormState());

  onUsernameChanged(String value) {
    final newUsername = Username.dirty(value);

    state = state.copyWith(
      username: newUsername,
      isValid: Formz.validate([
        newUsername,
        state.email,
        state.password,
        state.confirmPassword,
      ]),
    );
  }

  onEmailChanged(String value) {
    final newEmail = Email.dirty(value);

    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([
        state.username,
        newEmail,
        state.password,
        state.confirmPassword,
      ]),
    );
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);

    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([
        state.username,
        state.email,
        newPassword,
        state.confirmPassword,
      ]),
    );
  }

  onConfirmPasswordChanged(String value) {
    final newConfirmPassword = Password.dirty(value);

    state = state.copyWith(
      confirmPassword: newConfirmPassword,
      isValid: Formz.validate([
        state.username,
        state.email,
        state.password,
        newConfirmPassword,
      ]),
    );
  }

  onFormSubmit() async {
    _checkEveryField();

    if (!state.isValid || !_arePasswordsEqual()) return;

    await registerUserCallback(
        state.email.value, state.password.value, state.username.value);
  }

  bool _arePasswordsEqual() {
    return state.password.value == state.confirmPassword.value;
  }

  void _checkEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = Password.dirty(state.confirmPassword.value);
    final username = Username.dirty(state.username.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      username: username,
      password: password,
      confirmPassword: confirmPassword,
      isValid: Formz.validate([username, email, password, confirmPassword]),
    );
  }
}

// * Estado del formulario de registro
class RegisterFormState {
  final bool isPosting;
  final bool isFormValid;
  final bool isFormPosted;
  final bool isValid;
  final Username username;
  final Email email;
  final Password password;
  final Password confirmPassword;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isFormValid = false,
    this.isValid = false,
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure(),
  });

  @override
  String toString() {
    return '''
    RegisterFormState:
      isPosting: $isPosting,
      isFormValid: $isFormValid,
      isFormPosted: $isFormPosted,
      isValid: $isValid,
      username: $username,
      email: $email,
      password: $password,
      confirmPassword: $confirmPassword,
    ''';
  }

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormValid,
    bool? isFormPosted,
    bool? isValid,
    Username? username,
    Email? email,
    Password? password,
    Password? confirmPassword,
  }) =>
      RegisterFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormValid: isFormValid ?? this.isFormValid,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
      );
}

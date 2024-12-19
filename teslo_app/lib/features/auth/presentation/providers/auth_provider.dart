import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/shared/shared.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  // Implementamos el repositorio de autenticación
  final authRepository = AuthRepositoryImpl();

  // Implementamos el servicio de almacenamiento de valores clave
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  // Atributos de la clase
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  // Constructor de la clase
  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }) : super(AuthState());

  Future<void> loginUser(String email, String password) async {
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error inesperado');
    }
  }

  void registerUser(String email, String password, String fullName) async {
    try {
      final user = await authRepository.register(email, password, fullName);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error inesperado');
    }
  }

  void checkAuthStatus() async {}

  void _setLoggedUser(User user) async {
    // Se guarda el token en el almacenamiento local
    await keyValueStorageService.setKeyValue('token', user.token);
    state = state.copyWith(
      user: user,
      errorMessage: '',
      authStatus: AuthStatus.authenticated,
    );
  }

  Future<void> logout([String? errorMessage]) async {
    // Se elimina el token del almacenamiento local
    await keyValueStorageService.removeKey('token');
    state = state.copyWith(
      user: null,
      errorMessage: errorMessage,
      authStatus: AuthStatus.notAuthenticated,
    );
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  // Atributos de la clase
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  // Constructor de la clase
  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  // Método para crear una copia del objeto
  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

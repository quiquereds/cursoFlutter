import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  // Recibimos el datasource como parámetro, si no se recibe, se crea una instancia de AuthDataSourceImpl
  final AuthDataSource datasource;
  AuthRepositoryImpl({AuthDataSource? datasource})
      : datasource = datasource ?? AuthDataSourceImpl();

  // Implementamos los métodos de AuthRepository
  @override
  Future<User> checkAuthStatus(String token) =>
      datasource.checkAuthStatus(token);

  @override
  Future<User> login(String email, String password) =>
      datasource.login(email, password);

  @override
  Future<User> register(String email, String password, String fullName) =>
      datasource.register(email, password, fullName);
}

part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  // Atributos del Bloc
  final AuthorizationStatus status;
  // TODO: Crear modelo de notificaciones
  final List<dynamic> notifications;

  // Constructor con valores inicializados
  const NotificationsState({
    this.status = AuthorizationStatus.notDetermined,
    this.notifications = const [],
  });

  // Método para emitir un nuevo estado
  copyWith({
    AuthorizationStatus? status,
    List<dynamic>? notifications,
  }) =>

      /// Devolvemos un nuevo estado con los valores definidos, si son nulos,
      /// se conservan los datos del estado anterior.
      NotificationsState(
        status: status ?? this.status,
        notifications: notifications ?? this.notifications,
      );

  @override
  List<Object> get props => [status, notifications];
}

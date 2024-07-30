part of 'notifications_bloc.dart';

sealed class NotificationsEvent {
  const NotificationsEvent();
}

// Creamos un evento que se dispare al cambiar el permiso de notificaciones
class NotificationStatusChanged extends NotificationsEvent {
  // Solicitamos el estado como argumento
  final AuthorizationStatus status;

  NotificationStatusChanged(this.status);
}

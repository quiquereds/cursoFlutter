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

// Creamos un evento para manejar las notificaciones y el cambio de estado
class NotificationReceived extends NotificationsEvent {
  final PushMessage pushMessage;

  NotificationReceived(this.pushMessage);
}

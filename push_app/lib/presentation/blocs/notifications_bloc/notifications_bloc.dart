import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  // Instancia de Firebase Messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Inicialización del counter bloc con su respectivo estado inicial
  NotificationsBloc() : super(const NotificationsState()) {
    /// Desde aqui empiezan los manejadores de cada uno de los eventos definidos
    /// en el archivo notifications_event.dart
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    settings.authorizationStatus;
  }
}

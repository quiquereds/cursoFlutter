import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_app/config/local_notifications/local_notifications.dart';
import 'package:push_app/domain/entities/push_message.dart';
import 'package:push_app/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

/// En Flutter >=3.3.0 se añade este decorador para que la operación de
/// tree-shaking no remueva la función
@pragma('vm:entry-point')

/// Creamos una función top-level, es decir, fuera de clases que gestione el
/// recibimiento de background notifications, se va a llamar en el main
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  // Instancia de Firebase Messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // Controller del id del Local Notification
  int pushNumberId = 0;

  // Inicialización del counter bloc con su respectivo estado inicial
  NotificationsBloc() : super(const NotificationsState()) {
    /// Desde aqui empiezan los manejadores de cada uno de los eventos definidos
    /// en el archivo notifications_event.dart

    on<NotificationStatusChanged>(_notificationStatusChanged);
    on<NotificationReceived>(_onPushNotificationReceived);

    // Verificar permiso
    _initialStatusCheck();
    // Listener notificaciones en Foreground
    _onForegroundMessage();
  }

  //* Método estático encargado de la inicialización de Firebase (se llama en el main)
  static Future<void> initializeFCM() async {
    // Inicializamos Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  //* Método para almacenar la lógica del handler del evento
  void _notificationStatusChanged(
    NotificationStatusChanged event,
    Emitter<NotificationsState> emit,
  ) {
    // Actualizamos el método
    emit(state.copyWith(
      status: event.status,
    ));

    // Obtenemos el token
    _getFCMToken();
  }

  void _onPushNotificationReceived(
      NotificationReceived event, Emitter<NotificationsState> emit) {
    // Actualizamos el estado
    emit(state.copyWith(
      // Añadimos la notificacion a la lista y hacemos spread de todas las demas
      notifications: [event.pushMessage, ...state.notifications],
    ));
  }

  ///* Método para detectar si el usuario dió consentimiento a las notificaciones
  ///* para sobreescribir el estado inicial (notDetermined)
  void _initialStatusCheck() async {
    // Determinamos el estado actual del permiso
    final settings = await messaging.getNotificationSettings();

    // Disparamos el evento para actualizar el estado
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  //* Método para obtener el FCM Token del usuario
  void _getFCMToken() async {
    // Si el estado es distinto de autorizado, no se hace nada
    if (state.status != AuthorizationStatus.authorized) return;

    // Si las notificaciones están permitidas, obtenemos el token
    final token = await messaging.getToken();
    print(token);
  }

  //* Método para manejar las notificaciones que se reciben
  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;
    // Si la notificacion no es nula, creamos una entidad
    final notification = PushMessage(
      // Limpiamos el message id para evitar conflictos con GoRouter
      messageId:
          message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
      sentDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl: Platform.isAndroid
          ? message.notification!.android?.imageUrl
          : message.notification!.apple?.imageUrl,
    );

    // Mostramos una notificación local (si el usuario está en la app)
    LocalNotifications.showLocalNotification(
      id: ++pushNumberId,
      title: notification.title,
      body: notification.body,
      data: message.data.toString(),
    );
    // Disparamos el evento para actualizar el estado de los mensajes
    add(NotificationReceived(notification));
  }

  void _onForegroundMessage() {
    /// Escuchamos el stream de las notificaciones y pasamos el método que se
    /// encarga de procesarlas

    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  //* Método para manejar y actualizar el estado del permiso

  void requestPermission() async {
    // Solicitamos permisos para notificaciones push
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    // Solicitamos permisos para las notificaciones locales
    await LocalNotifications.requestPermissionLocalNotifications();

    // Disparamos el evento para actualizar el estado
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  ///* Método encargado de devolver un PushMessage basado en el id de la notificación
  PushMessage? getMessageById(String pushMessageId) {
    // Determinamos si en el estado existe una notificación con el id recibido
    final exist = state.notifications
        .any((element) => element.messageId == pushMessageId);

    // Basado en la búsqueda, devolvemos un PushMessage o no
    if (!exist) return null;

    return state.notifications
        .firstWhere((element) => element.messageId == pushMessageId);
  }
}

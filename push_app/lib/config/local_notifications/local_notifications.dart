import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_app/config/router/app_router.dart';

// Creamos una clase encargada de manejar la lógica de las notificaciones locales
class LocalNotifications {
  /// Solicitamos permisos de Local Notifications al usuario
  static Future<void> requestPermissionLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // Método encargado de inicializar el plugin de notificaciones locales
  static Future<void> initLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // TODO: iOS
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // Mandamos a llamar el método que maneja la interacción con la notificación
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  // Método para mostrar la notificación dentro de la app
  static void showLocalNotification({
    required int id,
    String? title,
    String? body,
    String? data,
  }) {
    // Personalización de la notificacion en Android
    const androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: true,
      // Asignamos un sonido personalizado (encontrado en android/app/src/main/res/raw)
      sound: RawResourceAndroidNotificationSound('notif_sound'),
      importance: Importance.high,
      priority: Priority.high,
    );

    // Agrupador de personalizaciones para iOS y Android
    const notificationDetails = NotificationDetails(
      android: androidDetails,
      // TODO: iOS
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Mostramos la Local Notification
    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: data,
    );
  }

  // Método que maneja la navegación al interactuar con una local notif
  static void onDidReceiveNotificationResponse(NotificationResponse response) {
    appRouter.push('/push-details/${response.payload}');
  }
}

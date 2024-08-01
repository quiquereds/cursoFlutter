import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
      onDidReceiveNotificationResponse: (details) {},
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
}

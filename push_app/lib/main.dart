import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/config/router/app_router.dart';
import 'package:push_app/config/theme/app_theme.dart';
import 'package:push_app/presentation/blocs/notifications_bloc/notifications_bloc.dart';

void main() async {
  /// Aseguramos que los widgets estén inicializados para poder
  /// inicializar la aplicación con Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Escuchamos las background notifications con el handler del bloc
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Inicializamos Firebase
  await NotificationsBloc.initializeFCM();

  runApp(
    /// Como desde nivel raíz de la aplicación, se van a ocupar determinados
    /// gestores de estado, se envuelve la app desde raíz dentro de un
    /// MultiblocProvider, para que desde que se abra, se inicialicen cada
    /// uno de los Blocs y/o Cubits y toda la app de Flutter tenga acceso a
    /// sus estados.
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NotificationsBloc()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,

      /// Envolvemos toda la app (incluyendo el router) en un builder para
      /// manejar las interacciones con las notificaciones.
      builder: (context, child) => HandleNotificationInteraction(child: child!),
    );
  }
}

// Widget para manejar interacciones con las notificiones push
class HandleNotificationInteraction extends StatefulWidget {
  final Widget child;

  const HandleNotificationInteraction({super.key, required this.child});

  @override
  State<HandleNotificationInteraction> createState() =>
      _HandleNotificationInteractionState();
}

class _HandleNotificationInteractionState
    extends State<HandleNotificationInteraction> {
  // Se establece comunicación con la interacción del push notification
  Future<void> setupInteractedMessage() async {
    // Se inicializa la instancia de Firebase Messaging
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // Si el mensaje no es nulo, se llama a la función para manejar el mensaje
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Se maneja cualquier interacción cuando la app está en el background mediante un stream
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    // Añadimos el mensaje al estado del NotificationsBloc
    context.read<NotificationsBloc>().handleRemoteMessage(message);

    // Manejamos la navegación al pulsar la notificación
    final messageId =
        message.messageId?.replaceAll(':', '').replaceAll('%', '');
    appRouter.push('/push-details/$messageId');
  }

  @override
  void initState() {
    super.initState();

    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

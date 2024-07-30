import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/config/router/app_router.dart';
import 'package:push_app/config/theme/app_theme.dart';
import 'package:push_app/presentation/blocs/notifications_bloc/notifications_bloc.dart';

void main() async {
  /// Aseguramos que los widgets estén inicializados para poder
  /// inicializar la aplicación con Firebase
  WidgetsFlutterBinding.ensureInitialized();

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
    );
  }
}

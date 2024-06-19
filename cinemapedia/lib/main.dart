import 'package:flutter/material.dart';

import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Convertimos la función main en asíncrona para importar
/// las variables de entorno
Future<void> main() async {
  // Esperamos y cargamos las variables de entorno
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Vinculamos GoRouter con la app
    return MaterialApp.router(
      // Título de la aplicación
      title: 'Cinemapedia',
      // Vinculamos la clase de configuración del tema
      theme: AppTheme().getTheme(),
      // Rutas de la aplicación
      routerConfig: appRouter,
      // Banner de debug del simulador
      debugShowCheckedModeBanner: false,
    );
  }
}

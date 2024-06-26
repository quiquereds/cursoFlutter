import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/router/app_router.dart';
import 'package:widgets_app/config/theme/app_theme.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

void main() {
  runApp(
    // Envolvemos MainApp en un ProviderScope para trabajar con Riverpod
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Escuchamos el tema de la aplicación basado en nuestro provider que
    /// devuelve un objeto de tipo AppTheme
    final AppTheme appTheme = ref.watch(themeNotifierProvider);

    // Vinculamos GoRouter con la app
    return MaterialApp.router(
      // Configuramos el título de la aplicación
      title: 'Flutter Widgets',
      // Especificamos la configuración del router
      routerConfig: appRouter,
      // Configuramos el tema
      theme: appTheme.getTheme(),
      debugShowMaterialGrid: false,
    );
  }
}

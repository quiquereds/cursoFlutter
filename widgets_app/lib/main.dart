import 'package:flutter/material.dart';
import 'package:widgets_app/config/router/app_router.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Vinculamos GoRouter con la app
    return MaterialApp.router(
      // Especificamos la configuración del router
      routerConfig: appRouter,
      theme: AppTheme(selectedColor: 4).getTheme(),
      debugShowMaterialGrid: false,
    );
  }
}

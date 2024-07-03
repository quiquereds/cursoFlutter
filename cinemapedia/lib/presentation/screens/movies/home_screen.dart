import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  /// Creamos el nombre de la ruta
  static const String name = 'home-screen';

  /// El shell de navegación y el contenedor para navegar entre ramas
  final StatefulNavigationShell navigationShell;

  const HomeScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CustomBottomNavigation(
        // Pasamos como argumento el shell de navegación
        navigationShell: navigationShell,
      ),
    );
  }
}

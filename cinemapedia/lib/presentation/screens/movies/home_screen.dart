import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  /// Creamos el nombre de la ruta
  static const String name = 'home-screen';

  /// El shell de navegación y el contenedor para navegar entre ramas
  final StatefulNavigationShell navigationShell;

  const HomeScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Creamos una referencia al controller del nabvar
    final bool showNavbar = ref.watch(showNavbarProvider);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: navigationShell),
          if (showNavbar)
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: CustomBottomNavigation(
                navigationShell: navigationShell,
              ),
            )
        ],
      ),
    );
  }
}

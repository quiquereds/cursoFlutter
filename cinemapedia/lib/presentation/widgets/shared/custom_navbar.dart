import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  // Recibimos el shell como argumento
  final StatefulNavigationShell navigationShell;

  const CustomBottomNavigation({
    super.key,
    required this.navigationShell,
  });

  // Creamos un método para alternar entre vistas mediante un switch
  void onItemTap(BuildContext context, int index) {
    /// Alternamos entre vistas mediante el método goBranch, este método
    /// garanriza que se restaure el último estado de navegación para la
    /// rama
    navigationShell.goBranch(
      index,
      // Soporte para ir a la ubicación inicial de la rama.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // Asignamos el índice actual en el que se encuentra el usuario
      currentIndex: navigationShell.currentIndex,
      onTap: (value) {
        // Llamamos a la función de navegación
        onItemTap(context, value);
      },
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          label: 'Inicio',
          icon: Icon(Icons.home_max),
        ),
        BottomNavigationBarItem(
          label: 'Categorias',
          icon: Icon(Icons.label_outline),
        ),
        BottomNavigationBarItem(
          label: 'Favoritos',
          icon: Icon(Icons.favorite_outline),
        ),
      ],
    );
  }
}

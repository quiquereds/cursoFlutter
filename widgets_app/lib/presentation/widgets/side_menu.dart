import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  /// Creamos una variable para determinar en qué índice
  /// del menú estamos
  int navDrawerIndex = 1;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
      // Asignamos el índice actual
      selectedIndex: navDrawerIndex,
      // Permite cambiar el índice al seleccionar una ópcion del menú
      onDestinationSelected: (value) {
        // Actualizamos el índice actual
        setState(() {
          navDrawerIndex = value;
        });

        // Desplazamos al usuario a la ruta elegida
        final menuItem = appMenuItem[value];
        context.push(menuItem.link);

        // Cerramos el drawer si está abierto
        widget.scaffoldKey.currentState?.closeDrawer();
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
          child: const Text('Menú principal'),
        ),

        /// Barremos todos los elementos de la lista del menú, tomamos los
        /// primeros 3 y los transformamos a una opción del menú drawer
        ...appMenuItem.sublist(0, 3).map(
              (menuItem) => NavigationDrawerDestination(
                icon: Icon(menuItem.icon),
                label: Text(menuItem.title),
              ),
            ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('Más opciones'),
        ),

        /// Mostramos las opciones faltantes
        ...appMenuItem.sublist(3).map(
              (menuItem) => NavigationDrawerDestination(
                icon: Icon(menuItem.icon),
                label: Text(menuItem.title),
              ),
            ),
      ],
    );
  }
}

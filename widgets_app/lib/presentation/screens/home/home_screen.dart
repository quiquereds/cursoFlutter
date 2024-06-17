import 'package:flutter/material.dart';
import 'package:widgets_app/config/menu/menu_items.dart';
import 'package:widgets_app/presentation/widgets/shared/menu_button.dart';
import 'package:widgets_app/presentation/widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {
  /// Definimos el nombre de la ruta
  /// La palabra reservada static, sirve para no crear instancias de
  /// HomeScreen al llamar a esta propiedad.
  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Creamos una referencia al scaffold para controlar el drawer
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Flutter + Material 3'),
      ),
      body: _HomeView(),
      // Mandamos la referencia de este scaffold a SideMenu
      drawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}

class _HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appMenuItem.length,
      itemBuilder: (context, index) {
        final MenuItem menuItem = appMenuItem[index];

        return MenuButton(menuItem: menuItem);
      },
    );
  }
}

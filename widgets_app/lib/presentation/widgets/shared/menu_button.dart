import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';

class MenuButton extends StatelessWidget {
  final MenuItem menuItem;

  const MenuButton({
    super.key,
    required this.menuItem,
  });

  @override
  Widget build(BuildContext context) {
    // Creamos una referencia a la paleta de colores de la app
    final appTheme = Theme.of(context).colorScheme;

    return ListTile(
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subtitle),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: appTheme.primary,
      ),
      leading: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: appTheme.inversePrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          menuItem.icon,
          color: appTheme.primary,
          size: 30,
        ),
      ),
      onTap: () {
        // Método de navegación con el constructor de la pantalla
        //  Navigator.of(context).push(
        //    MaterialPageRoute(
        //      builder: (context) => const CardsScreen(),
        //    ),
        //  );

        // Método de navegación por rutas
        //  Navigator.of(context).pushNamed(menuItem.link);

        // Navegación utilizando go_router
        context.push(menuItem.link);

        // Navegación utilizando rutas nombradas de go_router
        //  context.pushNamed(CardsScreen.name);
      },
    );
  }
}

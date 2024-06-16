// Opciones de menú (pantallas) de la aplicación
import 'package:flutter/material.dart';

// Creamos una clase que va a representar un objeto del menú
class MenuItem {
  // Atributos
  final String title;
  final String subtitle;
  final String link;
  final IconData icon;

  // Constructor de la clase
  const MenuItem({
    required this.title,
    required this.subtitle,
    required this.link,
    required this.icon,
  });
}

// Creamos la lista de opciones del menú
const List<MenuItem> appMenuItem = [
  MenuItem(
    title: 'Counter',
    subtitle: 'Un contador con Flutter y Riverpod',
    link: '/counter',
    icon: Icons.plus_one_rounded,
  ),
  MenuItem(
    title: 'Botones',
    subtitle: 'Varios botones de Flutter',
    link: '/buttons',
    icon: Icons.smart_button_outlined,
  ),
  MenuItem(
    title: 'Tarjetas',
    subtitle: 'Un contenedor estilizado',
    link: '/cards',
    icon: Icons.credit_card,
  ),
  MenuItem(
    title: 'Progress Indicators',
    subtitle: 'Generales y controlados',
    link: '/progress',
    icon: Icons.refresh_rounded,
  ),
  MenuItem(
    title: 'Snackbars y diálogos',
    subtitle: 'Indicadores en pantalla',
    link: '/snackbars',
    icon: Icons.info_outline_rounded,
  ),
  MenuItem(
    title: 'Animated Container',
    subtitle: 'Stateful Widget animado',
    link: '/animated',
    icon: Icons.check_box_outline_blank_rounded,
  ),
  MenuItem(
    title: 'UI Controls + Tiles',
    subtitle: 'Una serie de controles de Flutter',
    link: '/ui-controls',
    icon: Icons.car_rental_outlined,
  ),
  MenuItem(
    title: 'Introducción a la aplicación',
    subtitle: 'Pequeño tutorial introductorio',
    link: '/tutorial',
    icon: Icons.accessible_rounded,
  ),
  MenuItem(
    title: 'Infinite Scroll y Pull to Refresh',
    subtitle: 'Listas infinitas y pull to refresh',
    link: '/infinite',
    icon: Icons.list_rounded,
  ),
];

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
    title: 'Animados',
    subtitle: 'Un contenedor estilizado',
    link: '/animated',
    icon: Icons.sentiment_satisfied_outlined,
  ),
  MenuItem(
    title: 'App Tutorial',
    subtitle: 'Un contenedor estilizado',
    link: '/app_tutorial',
    icon: Icons.scatter_plot_sharp,
  ),
];

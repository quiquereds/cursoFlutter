import 'package:flutter/material.dart';

// Creamos una lista de colores predefinidos
const List<Color> colorList = [
  Colors.red,
  Colors.green,
  Colors.orange,
  Colors.blue,
  Colors.teal,
  Colors.purple,
  Colors.indigo
];

class AppTheme {
  // Propiedad para controlar el color seleccionado
  final int selectedColor;
  // Propiedad para controlar el tema oscuro
  final bool isDarkMode;

  // Inicializamos el constructor
  AppTheme({
    this.selectedColor = 0,
    this.isDarkMode = false,

    /// Creamos una aserción para que se evite la asignación de indices fuera
    /// del arreglo de colorList
  })  : assert(selectedColor <= colorList.length,
            'Color must be 0 - ${colorList.length - 1}'),
        assert(selectedColor >= 0, 'Color must be greater or equal than 0');

  // Creamos un método para devolver el tema actual
  ThemeData getTheme() {
    return ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      // Creamos la paleta de colores acorde con el indice elegido
      colorSchemeSeed: colorList[selectedColor],
      // Centramos los titulos de los Scaffold a nivel global
      appBarTheme: const AppBarTheme(
        centerTitle: true,
      ),
    );
  }
}

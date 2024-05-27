// Creamos una clase AppTheme
import 'package:flutter/material.dart';

// Color en formato hexadecimal
// Se usa guion bajo para mantener accesibles a las
// variables solo dentro de este archivo.
const Color _customColor = Color(0xFF5C11D4);

// Creamos una lista de colores que admite la app
const List<Color> _colorTheme = [
  _customColor,
  Colors.blue,
  Colors.green,
  Colors.red,
  Colors.orange,
  Colors.white,
  Colors.black
];

class AppTheme {
  // Creamos una variable para indicar el color seleccionado
  final int selectedColor;
  final bool darkThemeEnabled;

  /// Creamos el constructor de la clase inicializando
  /// el color en la posición 0.
  AppTheme({this.selectedColor = 0, this.darkThemeEnabled = false})

      /// Creamos una aserción para controlar que selectedColor debe ser mayor a 0
      /// y que debe ser un valor válido dentro de la lista _colorTheme
      : assert(selectedColor >= 0 && selectedColor <= _colorTheme.length,
            'must be between 0 and ${_colorTheme.length - 1}');

  /// Creamos una función que va a retornar un ThemeData.
  ThemeData theme() {
    // Retornamos el color con el valor de selectedColor
    return ThemeData(
      colorSchemeSeed: _colorTheme[selectedColor],
      brightness: darkThemeEnabled ? Brightness.dark : Brightness.light,
    );
  }
}

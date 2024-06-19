import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        // Usamos un color hexadecimal
        colorSchemeSeed: const Color(0xFF2062F5),
        // Configuración del appBar
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      );
}

import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        // Usamos un color hexadecimal
        colorSchemeSeed: const Color(0xFF2062F5),
        // Definimos las fuentes
        fontFamily: 'Gilroy',
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
}

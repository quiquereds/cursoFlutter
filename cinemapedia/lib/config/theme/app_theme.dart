import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        brightness: Brightness.dark,
        // Usamos un color hexadecimal
        colorSchemeSeed: const Color(0xFF135CC9),
        // Definimos las fuentes
        fontFamily: 'Gilroy',
        // Tema de los textos
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          displaySmall: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleSmall: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // Configuración de colores
        scaffoldBackgroundColor: const Color(0xFF0F0F16),
      );
}

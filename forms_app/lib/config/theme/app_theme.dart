import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() {
    return ThemeData(
      colorSchemeSeed: Colors.deepPurple,
      listTileTheme: const ListTileThemeData(
        iconColor: Colors.deepPurple,
      ),
    );
  }
}

import 'package:flutter/material.dart';

const seedColor = Color.fromARGB(255, 7, 80, 59);

class AppTheme {
  ThemeData getTheme() => ThemeData(
    colorSchemeSeed: seedColor,

    listTileTheme: ListTileThemeData(
      iconColor: seedColor,
    ),
  );
}

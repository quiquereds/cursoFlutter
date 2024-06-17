import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

// Creamos un provider que manejará un booleano
final isDarkModeProvider = StateProvider((ref) => false);

// Creamos un provider del listado de colores inmutable
final colorListProvider = Provider((ref) => colorList);

// Creamos un provider para manejar el color seleccionado del tema
final selectedColorProvider = StateProvider((ref) => 2);

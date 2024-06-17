import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

/// Provider -> Valores inmutables
/// StateProvider -> Mantiene una pieza de estado
/// StateNotifierProvider -> Mantiene un estado más complejo cuando el objeto
/// es más elaborado

// Creamos un provider que manejará un booleano
final isDarkModeProvider = StateProvider((ref) => false);

// Creamos un provider del listado de colores inmutable
final colorListProvider = Provider((ref) => colorList);

// Creamos un provider para manejar el color seleccionado del tema
final selectedColorProvider = StateProvider((ref) => 2);

/// Creamos un provider de nuestro objeto AppTheme (custom)
///
/// En el StateNotifierProvider se tiene que definir el controlador, que por defecto
/// es Null, y los datos o el objeto que se tiene que trabajar, es por ello
/// que a continuación se ve StateNotifierProvider<ThemeController, AppTheme>
final themeNotifierProvider = StateNotifierProvider<ThemeController, AppTheme>(
  // Devolvemos la primera instancia del themeNotifier
  (ref) => ThemeController(),
);

/// Creamos una clase para controlar el tema que va a mantener un
/// estado de la clase AppTheme
class ThemeController extends StateNotifier<AppTheme> {
  /// Creamos una instancia del AppTheme en el constructor con todos
  /// los valores por defecto
  ///
  /// State = new AppTheme();
  ThemeController() : super(AppTheme());

  // Ahora tendremos acceso al state
  void toggleDarkMode() {
    /// Usamos el copyWith para crear un nuevo estado de AppTheme que nos
    /// permitirá reemplazar sus propiedades
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changeColorIndex(int colorIndex) {
    // De igual forma, se usa el copyWith para sobreescribir propiedades
    state = state.copyWith(selectedColor: colorIndex);
  }
}

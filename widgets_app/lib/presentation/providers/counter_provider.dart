import 'package:flutter_riverpod/flutter_riverpod.dart';

/// El StateProvider básicamente es el proveedor de un estado y representa
/// una pieza pequeña de información del estado de la aplicación.
///
/// Ej. Estado de un valor numérico, tema seleccionado, estado de una clase, etc
final counterProvider = StateProvider((ref) => 5);

import 'package:intl/intl.dart';

class HumanFormats {
  /// Creamos un método estático para no generar instancias de la clase
  /// y poder utilizarlo directamente
  static String number(double number) {
    return NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol: '',
      locale: 'en',
    ).format(number);
  }

  // Método estático para darle un formato legible a la fecha
  static String shortDate(DateTime date) {
    // Creamos una instancia de DateFormat con locale en español
    final format = DateFormat.yMMMEd('es');

    // Retornamos la fecha con el nuevo formato
    return format.format(date);
  }
}

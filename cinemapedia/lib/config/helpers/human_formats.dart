import 'package:intl/intl.dart';

class HumanFormats {
  /// Creamos un método estático para no generar instancias de la clase
  /// y poder utilizarlo directamente
  static String number(double number) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en',
    ).format(number);

    return formattedNumber;
  }
}

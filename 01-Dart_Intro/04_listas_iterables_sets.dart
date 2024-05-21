void main() {
  // Lista en Dart
  final numbers = [1, 2, 3, 4, 5, 5, 5, 6, 7, 8, 9, 9];

  print('Lista original: $numbers');

  /// Métodos y propiedades
  // Mostramos cuántos elementos hay dentro de numbers
  print('Elementos: ${numbers.length}');

  // Mostramos el primer valor en la lista
  print('Primer valor: ${numbers[0]}');
  print('Primer valor: ${numbers.first}');

  // Invertimos los valores de la lista
  final reversedList = numbers.reversed;
  print('Orden inverso: $reversedList'); // Devuelve un iterable

  /// Si queremos recuperar el tipo de dato lista, podemos
  /// acceder al método 'toList'
  print('Lista: ${reversedList.toList()}');

  // Para convertir el iterable en un set
  print('Set: ${reversedList.toSet()}');

  /// Se pueden usar los iterables para hacer
  /// operaciones
  final numbersGreaterThan5 = numbers.where((int num) {
    /// En este caso, usamos el iterable para
    /// devolver todos los números mayores a 5
    return num > 5;
  });
  // Mostramos la variable
  print('>5: ${numbersGreaterThan5}');
  // ¿Elementos repetidos? Podemos eliminarlos con un set
  print('>5 Set: ${numbersGreaterThan5.toSet()}');
}

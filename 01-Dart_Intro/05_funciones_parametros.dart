void main() {
  print(greatEveryone()); // Llamamos a la función de saludo
  print(addTwoNumbers(10, 20)); // Llamamos a la función de suma enviando a + b
  print(addTwoNumbersOptional(
      10)); // Llamamos a la función de suma pero solo con un parámetro
}

// Función de saludo
String greatEveryone() {
  // Devolvemos el saludo
  return 'Hello Everyone';
}

/// Función de suma
/// Recibimos a y b y devolvemos la
/// operación de la suma
int addTwoNumbers(int a, int b) => a + b;

/// Si queremos hacer de un parámetro que sea opcional
/// el parametro se envuelve en corchetes y
/// asignando un valor inicial.
int addTwoNumbersOptional(int a, [int b = 0]) {
  /// Si b es nulo, la operación sería a + 0, en
  /// cambio, si b tiene valor se hace válida
  /// la operación a + b.
  return a + b;
}

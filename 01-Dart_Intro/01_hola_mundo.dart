void main() {
  // Inicialización de variable sin tipo de dato implicito
  var myName = "José Enrique";

  // Inicialización de variable con tipo de dato implicito (recomendado por legibilidad)
  String myName2 = "José Enrique";

  // Inicialización de variable final en tiempo de ejecución (no se puede cambiar su valor una vez asignado)
  final String myName3 = "José Enrique";

  // Inicialización de variable constante en tiempo de compilación (no se puede cambiar su valor una vez asignado)
  const String myName4 = "José Enrique";

  // Interpolación de cadenas
  print('Hola $myName');
  // Interpolación de cadenas con funciones o métodos
  print('Hola ${myName2.toUpperCase()}');
}

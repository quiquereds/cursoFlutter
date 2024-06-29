// Entidad de actor

// Regla de negocio de la estructura de datos de actores que
// va a tener la aplicación

class Actor {
  // Atributos de la clase
  final int id;
  final String name;
  final String profilePath;
  final String? character;

  // Constructor
  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.character,
  });
}

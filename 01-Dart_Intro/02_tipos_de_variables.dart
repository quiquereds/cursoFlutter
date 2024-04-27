void main() {
  //  Cadena de texto
  final String pokemon = "Pikachu";

  // Número entero
  final int health = 100;

  // Valor booleano
  final bool isAlive = true;

  // Lista de valores
  final List<String> abilities = ["Static", "Lightning Rod"];
  final sprites = <String>[
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png",
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
  ];

  // Print multilinea
  print("""
    Pokemon: $pokemon
    Health: $health
    Is Alive: $isAlive
    Abilities: $abilities
    Sprites: $sprites
  """);
}

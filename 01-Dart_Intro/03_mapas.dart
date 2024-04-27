void main() {
  // Mapa de pokemon
  final Map<String, dynamic> pokemon = {
    'name': 'Charmander',
    'hp': 100,
    'isAlive': true,
    'abilities': ['Ember', 'Scratch', 'Growl'],
    'sprites': {
      'front':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      'back':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/4.png'
    }
  };

  // Mostrar mapa en consola y acceder al nombre del pokemon
  print(pokemon);
  print(pokemon['name']);

  // Acceder a la lista de sprites
  final sprites = pokemon['sprites'];

  // Mostrar sprite back y front
  print(pokemon['sprites']['back']);
  print(sprites['front']);
  print(sprites['back']);
}

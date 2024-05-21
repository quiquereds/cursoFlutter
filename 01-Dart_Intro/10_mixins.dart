// Creamos la clase global
abstract class Animal {}

// Creamos 3 clases hijas englobando a tipos de animales
abstract class Mamifero extends Animal {}

abstract class Ave extends Animal {}

abstract class Pez extends Animal {}

// Creamos las especializaciones con los mixins
mixin Volador {
  void volar() => print('Estoy volando');
}
mixin Caminante {
  void caminar() => print('Estoy caminando');
}
mixin Nadador {
  void nadar() => print('Estoy nadando');
}

// Creamos animales para cada tipo con su especialización
class Delfin extends Mamifero with Nadador {}

class Murcielago extends Mamifero with Volador, Caminante {}

class Gato extends Mamifero with Caminante {}

class Paloma extends Ave with Caminante, Volador {}

class Pato extends Ave with Caminante, Volador, Nadador {}

class Tiburon extends Pez with Nadador {}

class PezVolador extends Pez with Nadador, Volador {}

void main() {
  // Creamos animales y accedemos a sus habilidades a través del mixin
  print('Defin');
  final flipper = Delfin();
  flipper.nadar();

  print('\nMurcielago');
  final batman = Murcielago();
  batman.caminar();
  batman.volar();

  print('\nPato');
  final nanor = Pato();
  nanor.caminar();
  nanor.volar();
  nanor.nadar();
}

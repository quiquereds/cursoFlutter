void main() {
  // Creamos un objeto a partir del molde Hero
  final Hero wolverine = Hero(name: 'Logan', power: 'Regeneración');
  print(wolverine);
  // Accedemos a las propiedades
  print(wolverine.name); // -> Logan
  print(wolverine.power); // -> Regeneración
}

class Hero {
  // Atributos
  String name;
  String power;

  // Inicialización de clase (constructor)
  Hero({required this.name, required this.power});
}

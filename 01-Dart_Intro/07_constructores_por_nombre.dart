void main() {
  // Ejemplo de petición HTTP
  final Map<String, dynamic> rawJson = {
    'name': 'Thor',
    'power': 'Truenos',
    'isAlive': true,
  };

  // Ejemplo de creación de objeto en app
  final Hero ironman = Hero(
    name: 'Tony Stark',
    power: 'Dinero',
    isAlive: false,
  );

  // Creamos un objeto a partir del JSON simulado
  final Hero thor = Hero.fromJson(rawJson);
  print(ironman.toString());
  print(thor.toString());
}

class Hero {
  // Propiedades
  String name;
  String power;
  bool isAlive;

  // Constructor principal
  Hero({required this.name, required this.power, required this.isAlive});

  // Constructor por nombre
  Hero.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? 'No name found',
        power = json['power'] ?? 'No power found',
        isAlive = json['isAlive'] ?? 'Not found';

  // Override de la función toString
  @override
  String toString() {
    return '$name, $power, Vivo: ${isAlive ? 'Siuuu' : 'Nope'}';
  }
}

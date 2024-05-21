void main() {
  final Square mySquare = Square(side: 15);
  mySquare.side = 5;
  print('Area: ${mySquare.area}');
}

class Square {
  // Propiedades
  double _side;

  // Constructor principal
  Square({required double side}) : _side = side;

  // Getter
  double get area {
    return _side * _side;
  }

  // Setter
  set side(double value) {
    print('Nuevo valor: $value');
    if (value < 0) throw 'Value must be >= 0';
    _side = value;
  }

  // Método (reemplazado por el getter)
  double calculateArea() {
    return _side * _side;
  }
}

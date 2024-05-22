void main() {
  // Escuchamos los valores de la función
  emitNumber().listen((event) {
    print('Stream value: $event');
  });
}

// Función que regresa un Stream
Stream<int> emitNumber() async* {
  final List valuesToEmit = [1, 2, 3, 4, 5];

  // Utilizamos un ciclo for para crear emisiones controladas con la lista anterior
  for (int i in valuesToEmit) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

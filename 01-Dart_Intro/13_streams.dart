void main() {
  // Escuhamos el stream
  emitNumbers().listen((value) {
    print('Stream value: $value'); // -> 1 ... 2 ... 3 ... 4
  }).cancel();
}

Stream<int> emitNumbers() {
  return Stream.periodic(const Duration(seconds: 2), (value) {
    return value;
  }).take(5); // Se escuchan las 5 primeras emisiones
}

void main() {
  print('Inicio del programa');

  httpGet('https://helloworld.com').then((value) {
    // Si la promesa es exitosa se retorna el resultado del Future
    print(value);
  }).catchError((err) {
    // Si la promesa no se cumple, se retorna el error
    print('Error: $err');
  });

  print('Fin del programa');
}

Future<String> httpGet(String url) {
  // Se hace una simulación de una petición http
  return Future.delayed(const Duration(seconds: 1), () {
    // Si la petición falla, se maneja el error
    throw 'Error en la petición http';

    //     return 'Respuesta de la petición http';
  });
}

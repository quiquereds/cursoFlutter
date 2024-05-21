void main() async {
  print('Inicio del programa');

  try {
    final value = await httpGet('https://helloworld.com');
    print(value);
  } catch (err) {
    print('Tenemos un error');
  }

  print('Fin del programa');
}

Future<String> httpGet(String url) async {
  // Esperamos a que se cumpla el Future
  await Future.delayed(const Duration(seconds: 1));
  // Regresa el valor
  return 'Valor HTTP';
}

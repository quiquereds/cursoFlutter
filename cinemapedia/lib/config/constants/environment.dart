import 'package:flutter_dotenv/flutter_dotenv.dart';

// Creamos una clase para manejar todas las constantes de entorno
class Environment {
  // Definimos la llave de TheMovieDB de forma estática
  static String theMovieDbKey =
      dotenv.env["THE_MOVIEDB_KEY"] ?? 'No hay API Key';
}

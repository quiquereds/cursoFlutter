import 'package:cinemapedia/domain/entities/movie_entity.dart';

// Clase abstracta para no generar instancias de la misma

/// En esta clase no se implementarán los métodos de cómo tiene que
/// fluir la información, sino, que solamente se va a específicar cómo
/// van a ser los orígenes de datos.
///
/// Se van a definir cómo lucen los orígenes de datos que pueden traer
/// películas
abstract class MoviesDatasource {
  // Método para obtener las películas en cartelera
  Future<List<Movie>> getNowPlaying({int page = 1});
}

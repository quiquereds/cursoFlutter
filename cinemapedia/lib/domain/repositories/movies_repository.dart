import 'package:cinemapedia/domain/entities/movie_entity.dart';

/// El objetivo del repositorio es mandar a llamar al datasource a través de
/// este, y permitir específicar de qué datasource vendrán los datos

abstract class MoviesRepository {
  // Método para obtener las películas en cartelera
  Future<List<Movie>> getNowPlaying({int page = 1});
}

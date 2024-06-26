import 'package:cinemapedia/domain/entities/movie_entity.dart';

/// El objetivo del repositorio es mandar a llamar al datasource a través de
/// este, y permitir específicar de qué datasource vendrán los datos

abstract class MoviesRepository {
  // Método para obtener las películas en cartelera
  Future<List<Movie>> getNowPlaying({int page = 1});

  // Método para obtener las películas populares
  Future<List<Movie>> getPopular({int page = 1});

  // Método para obtener películas a continuación
  Future<List<Movie>> getUpcoming({int page = 1});

  // Método para obtener películas mejor calificadas
  Future<List<Movie>> getTopRated({int page = 1});

  // Método para obtener los detalles de la película
  Future<Movie> getMovieByID(String id);
}

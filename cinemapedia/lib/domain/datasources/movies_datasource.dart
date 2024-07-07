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

  // Método para obtener las películas populares
  Future<List<Movie>> getPopular({int page = 1});

  // Método para obtener películas a continuación
  Future<List<Movie>> getUpcoming({int page = 1});

  // Método para obtener películas mejor calificadas
  Future<List<Movie>> getTopRated({int page = 1});

  // Método para obtener los detalles de la película
  Future<Movie> getMovieByID(String id);

  // Método para la búsqueda de películas
  Future<List<Movie>> searchMovies(String query);

  // Método para obtener las películas relacionadas de una película
  Future<List<Movie>> getSimilarMovies(int movieId);
}

import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/domain/entities/video_entity.dart';

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

  // Método para la búsqueda de películas
  Future<List<Movie>> searchMovies(String query);

  // Método para obtener las películas relacionadas de una película
  Future<List<Movie>> getSimilarMovies(int movieId);

  // Método para obtener los videos relacionados a una película
  Future<List<Video>> getYouTubeVideos(int movieId);
}

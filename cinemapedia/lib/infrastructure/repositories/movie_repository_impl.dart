// Implementación del repositorio

import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  // Solicitamos el datasource
  final MoviesDatasource datasource;
  MovieRepositoryImpl(this.datasource);

  // Llamamos a los métodos basándonos en el datasource que se manda
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) =>
      datasource.getNowPlaying(page: page);

  @override
  Future<List<Movie>> getPopular({int page = 1}) =>
      datasource.getPopular(page: page);

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) =>
      datasource.getUpcoming(page: page);

  @override
  Future<List<Movie>> getTopRated({int page = 1}) =>
      datasource.getTopRated(page: page);

  @override
  Future<Movie> getMovieByID(String id) => datasource.getMovieByID(id);

  @override
  Future<List<Movie>> searchMovies(String query) =>
      datasource.searchMovies(query);
}

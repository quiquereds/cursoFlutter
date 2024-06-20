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
}

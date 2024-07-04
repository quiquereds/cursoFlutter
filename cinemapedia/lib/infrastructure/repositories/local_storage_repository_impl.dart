import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  // Recibimos un DataSource como argumento (Atributo)
  final LocalStorageDatasource datasource;

  // Constructor
  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<bool> isMovieFavorite(int movieId) =>
      datasource.isMovieFavorite(movieId);

  @override
  Future<List<Movie>> loadFavoriteMovies({int limit = 10, offset = 0}) =>
      datasource.loadFavoriteMovies(limit: limit, offset: offset);

  @override
  Future<void> toggleFavorite(Movie movie) => datasource.toggleFavorite(movie);
}

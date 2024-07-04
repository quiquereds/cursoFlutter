import 'package:cinemapedia/domain/entities/movie_entity.dart';

abstract class LocalStorageRepository {
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  Future<List<Movie>> loadFavoriteMovies({int limit = 10, offset = 0});
}

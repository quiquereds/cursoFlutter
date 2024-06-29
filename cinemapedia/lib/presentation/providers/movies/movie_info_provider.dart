import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/* 
  El funcionamiento de este provider es el siguiente

  {
    '505465' : Movie(),
    '505466' : Movie(),
    '505467' : Movie(),

    ...
  },

  Devolver un mapa de ID's de películas apuntando a una Movie.
*/

// Creamos un provider encargado de manejar la búsqueda de películas por ID
final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  // Creamos una referencia a la implementación que se encarga de buscar películas
  final getMovieByID = ref.watch(movieRepositoryProvider).getMovieByID;

  return MovieMapNotifier(getMovie: getMovieByID);
});

// Creamos un callback personalizado para crear casos de uso
typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  // Pedimos el caso de uso
  final GetMovieCallback getMovie;

  // Constructor del Notifier
  MovieMapNotifier({required this.getMovie}) : super({});

  // Llamamos a la implementación de la función que carga la película
  Future<void> loadMovie(String movieId) async {
    /// Determinamos si el estado actual ya tiene cargada en caché la
    /// película, en ese caso, se cancela la petición
    if (state[movieId] != null) return;

    // Si no está cargada la película, se hace la petición
    final movie = await getMovie(movieId);

    // Hacemos la actualización del estado
    state = {...state, movieId: movie};
  }
}

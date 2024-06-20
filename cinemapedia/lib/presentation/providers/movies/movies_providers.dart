import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/movie_entity.dart';

/// Provider responsable de mostrar las películas en cartelera
///
/// Recordatorio: El StateNotifierProvider es un proveedor
/// de un estado que notifica su cambio
///
/// Especificamos que en controlador es un MoviesNotifier y la
/// información que fluye en el provider es un listado de Movie
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    /// Creamos una referencia (caso de uso) al provider que se encarga de
    /// inicializar el repositorio
    final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

    // Retornamos una instancia de MoviesNotifier
    return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
  },
);

// Definir casos de uso
typedef MovieCallback = Future<List<Movie>> Function({int page});

/// Creamos una clase para controlar casos de uso sobre qué
/// provider queremos escuchar en segmentos de la aplicación
class MoviesNotifier extends StateNotifier<List<Movie>> {
  // Creamos un controlador de la página actual
  int currentPage = 0;

  // Recibimos el caso de uso
  MovieCallback fetchMoreMovies;

  /// Creamos el constructor de la clase, que al
  /// inicializarse tendrá un arreglo vacío de Movie
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  // Creamos una función que modificará el estado de la página actual
  Future<void> loadNextPage() async {
    // Incrementamos el controlador
    currentPage++;

    // Llamamos a la función de caso de uso
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    // Reemplazamos el estado por uno nuevo
    state = [...state, ...movies];
  }
}

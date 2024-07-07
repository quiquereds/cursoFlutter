import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/movie_entity.dart';

///* Provider responsable de mostrar las películas en cartelera
///
/// Recordatorio: El StateNotifierProvider es un proveedor
/// de un estado que notifica su cambio
///
/// Especificamos que en controlador es un MoviesNotifier y la
/// información que fluye en el provider es un listado de Movie
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  /// Creamos una referencia (caso de uso) al provider que se encarga de
  /// inicializar el repositorio
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  // Retornamos una instancia de MoviesNotifier
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

//* Provider encargado de mostrar las películas populares
final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  /// Creamos una referencia (caso de uso) al provider que se encarga de
  /// inicializar el repositorio
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;

  // Retornamos una instancia de MoviesNotifier
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

//* Provider encargado de mostrar las películas a continuación
final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  /// Creamos una referencia (caso de uso) al provider que se encarga de
  /// inicializar el repositorio
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;

  // Retornamos una instancia de MoviesNotifier
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

//* Provider encargado de mostrar las películas mejor calificadas
final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  /// Creamos una referencia (caso de uso) al provider que se encarga de
  /// inicializar el repositorio
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;

  // Retornamos una instancia de MoviesNotifier
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

// Definir casos de uso
typedef MovieCallback = Future<List<Movie>> Function({int page});

/// Creamos una clase para controlar casos de uso sobre qué
/// provider queremos escuchar en segmentos de la aplicación
class MoviesNotifier extends StateNotifier<List<Movie>> {
  // Creamos un controlador de la página actual
  int currentPage = 0;
  // Creamos una bandera para controlar el flujo de peticiones
  bool isLoading = false;

  // Recibimos el caso de uso
  MovieCallback fetchMoreMovies;

  /// Creamos el constructor de la clase, que al
  /// inicializarse tendrá un arreglo vacío de Movie
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  // Creamos una función que modificará el estado de la página actual
  Future<void> loadNextPage() async {
    // Si la bandera está en true, salimos de la función
    if (isLoading) return;

    // Actualizamos la bandera
    isLoading = true;

    // Incrementamos el controlador
    currentPage++;

    // Llamamos a la función de caso de uso
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    // Hacemos un spread del estado y listado anterior para sumar el nuevo
    state = [...state, ...movies];

    // Damos un tiempo a que las películas se renderizen
    await Future.delayed(const Duration(milliseconds: 300));

    // Actualizamos la bandera al terminar
    isLoading = false;
  }
}

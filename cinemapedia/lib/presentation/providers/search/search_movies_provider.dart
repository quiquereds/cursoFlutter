import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Creamos un provider que va a retornar un String vacio
final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  // Creamos una referencia a la función de búsqueda de películas del repositorio
  final searchMovies = ref.read(movieRepositoryProvider).searchMovies;

  // Llamamos al notifier con la referencia de la función creada
  return SearchedMoviesNotifier(
    searchMovies: searchMovies,
    ref: ref,
  );
});

// Creamos una función personalizada para recibir casos de uso
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  // Atributos del notifier
  final SearchMoviesCallback searchMovies;
  final Ref ref;

  // Constructor del notifier
  SearchedMoviesNotifier({
    required this.searchMovies,
    required this.ref,
  }) : super([]);

  // Creamos una función encargada de guardar en memoria el listado de películas
  Future<List<Movie>> searchMoviesByQuery(String query) async {
    // Hacemos la petición con el caso de uso recibido
    final List<Movie> movies = await searchMovies(query);

    // Actualizamos el estado del query para almacenar en memoria la última búsqueda
    ref.read(searchQueryProvider.notifier).update((state) => query);

    // Almacenamos en memoria el listado de películas de la última búsqueda
    /// A diferencia de otros providers, aqui no se hace uso del spread porque la
    /// intención no es almacenar cada listado de cada petición, sino únicamente
    /// conservar el estado de la última búsqueda, el cual será reemplazado cuando se
    /// haga otra búsqueda.
    state = movies;

    // Retornamos la lista
    return movies;
  }
}

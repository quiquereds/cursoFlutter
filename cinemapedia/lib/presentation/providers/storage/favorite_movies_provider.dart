import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
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

  Devolver un mapa de ID's de películas apuntando a la película
*/

// Creamos un provider que va a mantener el estado del listado de películas favoritas
final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  // Creamos una referencia al repositorio de almacenamiento local
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

// Creamos el Notifier del Provider
class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  // Pedimos como atributo el repositorio que va a llamar al datasource
  final LocalStorageRepository localStorageRepository;

  // Creamos un controlador de página
  int page = 0;

  /// Creamos el constructor de la clase con la inicialización de un mapa vacio
  /// y solicitando el repositorio para tener acceso a los métodos
  StorageMoviesNotifier({
    required this.localStorageRepository,
  }) : super({});

  // Método para cargar la siguiente página
  Future<List<Movie>> loadNextPage() async {
    // Cargamos las películas y las almacenamos en movies
    final movies = await localStorageRepository.loadFavoriteMovies(
        offset: page * 10, limit: 20);

    // Incrementamos el contador
    page++;

    // Convertimos la lista de películas en un mapa de id's apuntando a películas
    // Inicializamos un mapa vacío
    Map<int, Movie> tempMoviesMap = {};
    for (final movie in movies) {
      // Vamos barriendo cada película de la lista para crear un mapa
      tempMoviesMap[movie.id] = movie;
    }

    // Actualizamos el estado con un spread
    state = {...state, ...tempMoviesMap};

    return movies;
  }

  // Creamos un nuevo método en el Notifier para cambiar el estado de favorito
  Future<void> toggleFavorite(Movie movie) async {
    // Llamamos al repositorio que va a pedir al datasource que remueva o añada a lista
    await localStorageRepository.toggleFavorite(movie);

    // Determinamos si la película existe en la lista de favoritos
    final bool isMovieInFavorite = state[movie.id] != null;

    if (isMovieInFavorite) {
      // Removemos la película
      state.remove(movie.id);
      // Disparamos la renderización para quitar la película
      state = {...state};
    } else {
      // Añadimos la película al mapa
      state = {...state, movie.id: movie};
    }
  }
}

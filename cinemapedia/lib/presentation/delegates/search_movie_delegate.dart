import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';

// Creamos una firma de función
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

/// Creamos una clase encargada de gestionar la búsqueda indicando que el valor
/// de retorno va a ser un objeto de tipo Movie
class SearchMovieDelegate extends SearchDelegate<Movie?> {
  // Creamos los atributos
  final SearchMoviesCallback searchMovie;
  List<Movie> initialMovies;

  /// Utilizamos un StreamController para tener acceso al listener de eventos
  /// se utiliza el broadcast cuando no se sabe cuántos widgets están escuchando
  /// Va a tener la lista de películas en el stream
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();

  // Creamos un controlador booleano para determinar si se están buscando peliculas
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  /// Creamos un timer para controlar el flujo de peticiones, de manera que se
  /// realicen cuando el usuario deja de escribir por un tiempo determinado
  Timer? _debounceTimer;

  // Creamos el constructor
  SearchMovieDelegate({
    required this.searchMovie,
    // Inicializamos las peliculas iniciales con una lista vacia
    this.initialMovies = const [],
  });

  // Creamos un método para limpiar todas las instancias de Streams de memoria
  void clearStreams() {
    debouncedMovies.close();
    isLoadingStream.close();
  }

  // Creamos un método encargado de emitir el resultado de las películas
  void _onQueryChanged(String query) {
    // Tan pronto la persona empiece a escribir, emitimos un valor a la bandera
    isLoadingStream.add(true);

    /// Si el timer está activo, se cancela.
    /// Es decir, si el usuario va cambiando el query, el timer se cancela para
    /// que no se hagan peticiones mientras se está escribiendo
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    /// Inicializamos el timer con una duración de 500 milisegundos, posterior
    /// a este tiempo es cuando se realiza la petición.
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // Si hay algún valor en el query, hacemos la petición
      final movies = await searchMovie(query);
      debouncedMovies.add(movies);
      // Asignamos las películas encontradas a la variable
      initialMovies = movies;
      // Luego de que se reflejen los resultados, vuelve a cambiar la bandera
      isLoadingStream.add(false);
    });
  }

  // Creamos un método que va a retornar el widget del listado de películas
  Widget _buildResultsAndSuggestions() {
    return StreamBuilder(
      // Mostramos el listado de películas que estén en memoria
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final List<Movie> movies = snapshot.data ?? [];
        // Usamos un ListView para renderizar los resultados
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final Movie movie = movies[index];

            /// Renderizamos la película y mandamos la función close como referencia
            /// para regresar de la búsqueda con argumentos al seleccionar una película
            return _MovieSearchItem(
              movie: movie,
              onMovieSelected: (context, movie) {
                // Limpiamos los streams
                clearStreams();
                // Volvemos con argumento para pasar a MovieDetails si hay película
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }

  // Sobreescribimos el String del hint label;
  @override
  String get searchFieldLabel => 'Buscar película';

  // Construcción de acciones del widget
  // Lista de íconos en la parte lateral derecha del TextField
  @override
  List<Widget>? buildActions(Object context) {
    return [
      // Creamos un streamBuilder para trabajar con el isLoading controller
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          // Si la bandera es verdadera, indicamos el progreso de carga
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 5),
              infinite: true,
              spins: 10,
              child: IconButton(
                /// Actualizamos el query (palabra reservada del delegate) a un String vacio
                /// para limpiar la búsqueda.
                onPressed: () => query = '',
                icon: const Icon(Icons.refresh),
              ),
            );
          }

          // Si la bandera es falsa, mostramos el icono de limpieza
          return FadeIn(
            // Animamos el botón para qe solo salga cuando hay valor en el query
            animate: query.isNotEmpty,
            duration: const Duration(milliseconds: 200),
            child: IconButton(
              /// Actualizamos el query (palabra reservada del delegate) a un String vacio
              /// para limpiar la búsqueda.
              onPressed: () => query = '',
              icon: const Icon(Icons.clear_rounded),
            ),
          );
        },
      ),
    ];
  }

  // Construir la parte del inicio
  // Widgets en la parte lateral izquierda del TextField
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      /// Al presionar el botón devolvemos el context y null (debido a que se
      /// interpreta que no se seleccionó ninguna película)
      onPressed: () {
        // Limpiamos los streams
        clearStreams();

        /// Retornamos sin argumentos
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  // Construir la parte de resultados
  // El ListView que se muestra al hacer una consulta
  @override
  Widget buildResults(BuildContext context) {
    // Mostramos la lista de resultados
    return _buildResultsAndSuggestions();
  }

  // Construir sugerencias
  /// Widget que se construye al inicializar la búsqueda, va llamando a una función
  /// mientras se va actualizando el query
  @override
  Widget buildSuggestions(BuildContext context) {
    /// Llamamos a la función de control de peticiones cada que se haga
    /// un cambio en el query
    _onQueryChanged(query);

    // Mostramos la lista de sugerencias
    return _buildResultsAndSuggestions();
  }
}

class _MovieSearchItem extends StatelessWidget {
  final Movie movie;
  final Function(BuildContext context, Movie movie) onMovieSelected;

  const _MovieSearchItem({
    required this.movie,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Hacemos una referencia al estilo de la aplicación
    final size = MediaQuery.of(context).size;
    final textStyleTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        // Llamamos a la función recibida
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // Imagen
            SizedBox(
              width: size.width * 0.3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) {
                    return FadeIn(child: child);
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Descripcion
            SizedBox(
              width: size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titulo
                  Text(
                    movie.title,
                    style: textStyleTheme.titleMedium,
                  ),
                  // Descripción
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  // Rating
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage),
                        style: textStyleTheme.bodyMedium!
                            .copyWith(color: Colors.yellow.shade900),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
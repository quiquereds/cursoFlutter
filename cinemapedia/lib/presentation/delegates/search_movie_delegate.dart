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

  // Creamos el constructor
  SearchMovieDelegate({required this.searchMovie});

  // Sobreescribimos el String del hint label;
  @override
  String get searchFieldLabel => 'Buscar película';

  // Construcción de acciones del widget
  // Lista de íconos en la parte lateral derecha del TextField
  @override
  List<Widget>? buildActions(Object context) {
    return [
      FadeIn(
        // Animamos el botón para qe solo salga cuando hay valor en el query
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 200),
        child: IconButton(
          /// Actualizamos el query (palabra reservada del delegate) a un String vacio
          /// para limpiar la búsqueda.
          onPressed: () => query = '',
          icon: const Icon(Icons.clear_rounded),
        ),
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
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  // Construir la parte de resultados
  // El ListView que se muestra al hacer una consulta
  @override
  Widget buildResults(BuildContext context) {
    return const Text('BuildResults');
  }

  // Construir sugerencias
  // Widget que se construye al inicializar la búsqueda
  @override
  Widget buildSuggestions(BuildContext context) {
    // Usamos un FutureBuilder para trabajar con la función
    return FutureBuilder(
      future: searchMovie(query),
      builder: (context, snapshot) {
        final List<Movie> movies = snapshot.data ?? [];
        // Usamos un ListView para renderizar los resultados
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final Movie movie = movies[index];

            /// Renderizamos la película y mandamos la función close como referencia
            /// para regresar de la búsqueda con argumentos al seleccionar una película
            return _MovieSearchItem(movie: movie, onMovieSelected: close);
          },
        );
      },
    );
  }
}

class _MovieSearchItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

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

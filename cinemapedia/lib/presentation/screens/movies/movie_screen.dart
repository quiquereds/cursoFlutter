import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// * Pantalla de detalles de la película
class MovieScreen extends ConsumerStatefulWidget {
  static const String name = 'movie-screen';

  // Recibimos el ID de la película como parámetro (NO el objeto Movie)
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    // Hacemos la petición a través del provider
    /// Se hace uso de read cuando se quiere conocer el valor del
    /// provider una sola vez
    // * Cargamos detalles de la película
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    // * Cargamos la lista de actores
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    /// Creamos un objeto de la película a través del provider
    /// Aqui se usa el watch para obtener los nuevos valores si es
    /// que cambia el estado
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    // Si la película es nula, devolvemos un indicador de carga
    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // En cambio, si la película existe, mostramos la pantalla
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(
                movie: movie,
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

// * Cuerpo de la pantalla de detalles (descripcion, generos, actores)
class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    // Obtenemos medidas y temas del dispositivo
    final size = MediaQuery.of(context).size;
    final textStyleTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* Descripción de la película
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen de la pelicula
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.posterPath, width: size.width * 0.3),
              ),
              const SizedBox(width: 10),
              // Descripción
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyleTheme.titleLarge,
                    ),
                    Text(
                      movie.overview,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        //* Géneros de la película
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              // Barremos todos los generos de la película para hacerlos widget
              ...movie.genreIds.map(
                (genre) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(genre),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // * Actores de la película
        ActorsByMovie(movieId: movie.id.toString()),
      ],
    );
  }
}

// * SliverAppBar (Background, Botones de flecha y favoritos)
class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtenemos las dimesiones del dispositivo
    final size = MediaQuery.of(context).size;

    // Obtenemos el color del scaffold
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    // Tomamos la instancia del FutureProvider (isFavoriteProvider)
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    return SliverAppBar(
      backgroundColor: Colors.black,
      // Definimos la altura ocupando el 70% del dispositivo
      expandedHeight: size.height * 0.4,
      foregroundColor: Colors.white,
      // Listado de Widgets de acciones (iconos a la derecha)
      actions: [
        IconButton(
          onPressed: () async {
            // Llamamos a la función de toggle desde el Provider
            // await ref
            //     .read(localStorageRepositoryProvider)
            //     .toggleFavorite(movie);
            await ref
                .read(favoriteMoviesProvider.notifier)
                .toggleFavorite(movie);

            // Invalidamos el provider para que se confirme el valor
            ref.invalidate(isFavoriteProvider(movie.id));
          },

          /// Usamos el isFavoriteFuture con el helper when para determinar el widget
          icon: isFavoriteFuture.when(
            // Cuando se obtiene el valor del Future mostramos un ícono u otro
            data: (isFavorite) => isFavorite
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite_border),
            error: (_, __) => throw UnimplementedError(),
            // Mientras se resuelve el Future mostramos un círculo de carga
            loading: () => const CircularProgressIndicator(),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        title: Text(
          movie.title,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        background: Stack(
          children: [
            // Imagen
            SizedBox.expand(
              child: Image.network(
                movie.backdropPath,
                fit: BoxFit.cover,
                // Controlamos la carga de la imágen
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();

                  return FadeIn(child: child);
                },
              ),
            ),

            // Gradiente de icono favoritos
            const _CustomGradient(
              gradientBegin: Alignment.topRight,
              gradientEnd: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [
                Colors.black54,
                Colors.transparent,
              ],
            ),

            // Gradiente de imagen
            _CustomGradient(
              gradientBegin: Alignment.topCenter,
              gradientEnd: Alignment.bottomCenter,
              stops: const [0.4, 1.0],
              colors: [
                Colors.transparent,
                scaffoldBackgroundColor,
              ],
            ),

            // Gradiente icono de flecha
            const _CustomGradient(
              gradientBegin: Alignment.topLeft,
              stops: [0.0, 0.3],
              colors: [
                Colors.black87,
                Colors.transparent,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// * Widget personalizado de gradiente
class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;
  final List<double>? stops;
  final List<Color> colors;

  const _CustomGradient({
    this.gradientBegin = Alignment.centerLeft,
    this.gradientEnd = Alignment.centerRight,
    this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: gradientBegin,
            end: gradientEnd,
            stops: stops!,
            colors: colors,
          ),
        ),
      ),
    );
  }
}

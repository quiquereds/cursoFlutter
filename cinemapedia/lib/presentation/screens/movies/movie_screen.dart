import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.all(8),
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
        _ActorsByMovie(movieId: movie.id.toString()),
        const SizedBox(height: 20)
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Creamos una referencia al estilo de texto
    final textStyleTheme = Theme.of(context).textTheme;

    // Creamos una referencia a la lista de actores por película
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    // Mientras no esté la película, mostramos un indicador de carga
    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        // Control del tamaño del ListView
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actorsByMovie[movieId]!.length,
          itemBuilder: (context, index) {
            final actorsList = actorsByMovie[movieId]![index];

            return Row(
              children: [
                FadeInRight(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            child: Image.network(
                              actorsList.profilePath,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            // Control de ancho de columnas de texto
                            width: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  actorsList.name,
                                  maxLines: 2,
                                  style: textStyleTheme.titleMedium!.copyWith(
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  actorsList.character!,
                                  style: textStyleTheme.bodyMedium!.copyWith(
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    // Obtenemos las dimesiones del dispositivo
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      // Definimos la altura ocupando el 70% del dispositivo
      expandedHeight: size.height * 0.4,
      foregroundColor: Colors.white,
      // Listado de Widgets de acciones (iconos a la derecha)
      actions: [
        IconButton(
          onPressed: () {
            // TODO: Realizar el toggle
          },
          icon: const Icon(Icons.favorite_border),
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
            const _CustomGradient(
              gradientBegin: Alignment.topCenter,
              gradientEnd: Alignment.bottomCenter,
              stops: [0.8, 1.0],
              colors: [Colors.transparent, Colors.black54],
            ),
            // Gradiente icono de flecha
            const _CustomGradient(
              gradientBegin: Alignment.topLeft,
              stops: [0.0, 0.3],
              colors: [Colors.black87, Colors.transparent],
            ),
          ],
        ),
      ),
    );
  }
}

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

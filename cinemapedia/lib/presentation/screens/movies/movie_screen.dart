import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/views/transparent_view.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

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
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
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
        //* Título, descripción, generos y rating de la película
        _TitleAndOverview(
          movie: movie,
          size: size,
          textStyleTheme: textStyleTheme,
        ),

        const SizedBox(height: 20),

        //* Actores de la película
        ActorsByMovie(movieId: movie.id.toString()),

        const SizedBox(height: 20),

        //* Películas similares
        SimilarMovies(movieId: movie.id),
      ],
    );
  }
}

class _Genres extends StatelessWidget {
  const _Genres({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        // Barremos todos los generos de la película para hacerlos widget
        ...movie.genreIds.map(
          (genre) => Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF0c2345).withAlpha(400),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(genre),
            ),
          ),
        ),
      ],
    );
  }
}

class _TitleAndOverview extends StatelessWidget {
  const _TitleAndOverview({
    required this.movie,
    required this.size,
    required this.textStyleTheme,
  });

  final Movie movie;
  final Size size;
  final TextTheme textStyleTheme;

  @override
  Widget build(BuildContext context) {
    // Obtenemos el color del scaffold
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      height: size.height * 0.7,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(movie.backdropPath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // * Gradiente superior
          _CustomGradient(
            gradientBegin: Alignment.bottomCenter,
            gradientEnd: Alignment.topCenter,
            stops: const [0.6, 1.0],
            colors: [
              Colors.transparent,
              scaffoldBackgroundColor,
            ],
          ),
          // * Gradiente inferior
          _CustomGradient(
            gradientBegin: Alignment.topCenter,
            gradientEnd: Alignment.bottomCenter,
            stops: const [0.1, 1.0],
            colors: [
              Colors.transparent,
              scaffoldBackgroundColor,
            ],
          ),
          // * Botón de reprodución de video
          Positioned(
            top: size.height * 0.20,
            left: size.width * 0.40,
            child: BounceInUp(
              child: BlurredIconButton(
                icon: const Icon(IconlyBold.play, size: 50),
                buttonShape: BoxShape.circle,
                width: 80,
                height: 80,
                blurColor: Colors.transparent,
                borderRadius: 40,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransparentView(
                      widget: VideosFromMovie(movieId: movie.id),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: SizedBox(
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nombre de la película
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: textStyleTheme.displaySmall,
                    ),
                    const SizedBox(height: 10),
                    // Año y duración
                    Row(
                      children: [
                        MovieRating(voteAverage: movie.voteAverage),
                        const SizedBox(width: 10),
                        Text(
                          '${HumanFormats.getYear(movie.releaseDate!)} • ${movie.runtime} min',
                          style: textStyleTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    //* Géneros de la película
                    _Genres(movie: movie),
                    const SizedBox(height: 15),
                    Text(
                      movie.overview,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// * SliverAppBar (Background, Botones de flecha y favoritos)
class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tomamos la instancia del FutureProvider (isFavoriteProvider)
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    // Obtenemos el color del scaffold
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return SliverAppBar(
      // Configuración del appbar
      floating: true,

      // Blur del AppBar
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
      backgroundColor: scaffoldBackgroundColor.withAlpha(200),

      // Listado de Widgets de acciones (iconos a la derecha)
      actions: [
        IconButton(
          onPressed: () async {
            // Llamamos a la función de toggle desde el Provider
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
                ? const Icon(IconlyBold.bookmark, color: Colors.yellow)
                : const Icon(IconlyLight.bookmark),
            error: (_, __) => throw UnimplementedError(),
            // Mientras se resuelve el Future mostramos un círculo de carga
            loading: () => SpinPerfect(
              infinite: true,
              child: const Icon(
                Icons.refresh,
              ),
            ),
          ),
        ),
      ],
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

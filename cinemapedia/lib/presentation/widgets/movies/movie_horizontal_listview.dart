import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:cinemapedia/presentation/providers/storage/local_storage_provider.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  // Función opcional para disparar funciones
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subtitle,
    this.loadNextPage,
  });

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  // Creamos un controlador del scroll
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Añadimos el listener del scroll
    scrollController.addListener(() {
      // Si no existe un método de loadNextPage no se hace nada
      if (widget.loadNextPage == null) return;

      // Posición actual
      final currentPosition = scrollController.position.pixels;

      // Posición de desplazamiento máxima
      final maxScroll = scrollController.position.maxScrollExtent;

      // Determinamos si nos encontramos cerca del scroll maxima
      if (currentPosition + 200 >= maxScroll) {
        // Mandamos a llamar la función
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    // Creamos el dispose del listener para liberar los recursos de memoria
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          /// Solo si el widget cuenta con titulo o subtitulo se renderiza
          /// el widget _Title
          if (widget.title != null || widget.subtitle != null)
            _Title(
              title: widget.title,
              subtitle: widget.subtitle,
            ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              // Asociamos el controller al ListView
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends ConsumerWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tomamos la instancia del FutureProvider (isFavoriteProvider)
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    // Accedemos al estilo de la aplicación
    final textStyleTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Portada de la película
          Stack(
            children: [
              SizedBox(
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: GestureDetector(
                    onTap: () => context.push('/movie/${movie.id}'),
                    child: FadeInImage(
                      height: 220,
                      fit: BoxFit.cover,
                      placeholder: const AssetImage(
                          'lib/assets/loaders/shimmerEffect.gif'),
                      image: NetworkImage(movie.posterPath),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: MovieRating(voteAverage: movie.voteAverage),
              ),
              Positioned(
                top: 6,
                left: 6,
                child: BlurredIconButton(
                  width: 35,
                  height: 35,
                  blurColor: Colors.grey.shade800.withAlpha(800),
                  borderRadius: 12,
                  onTap: () async {
                    await ref
                        .read(favoriteMoviesProvider.notifier)
                        .toggleFavorite(movie);

                    // Invalidamos el provider para que se confirme el valor
                    ref.invalidate(isFavoriteProvider(movie.id));
                  },
                  icon: isFavoriteFuture.when(
                    // Cuando se obtiene el valor del Future mostramos un ícono u otro
                    data: (isFavorite) => isFavorite
                        ? const Icon(
                            IconlyBold.bookmark,
                            color: Colors.yellow,
                            size: 20,
                          )
                        : const Icon(
                            IconlyLight.bookmark,
                            size: 20,
                          ),
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
              ),
            ],
          ),
          const SizedBox(height: 5),
          //* Título
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyleTheme.titleMedium,
            ),
          ),
          if (movie.releaseDate != null)
            SizedBox(
              width: 150,
              child: Text(
                HumanFormats.getYear(movie.releaseDate!),
                maxLines: 2,
                style: textStyleTheme.titleSmall!
                    .copyWith(color: colors.inversePrimary),
              ),
            ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _Title({
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final textStyleTheme = Theme.of(context).textTheme;

    return Container(
      // Creamos separación vertical entre widgets
      padding: const EdgeInsets.only(top: 10),
      // Creamos un margen para que el hijo no esté pegado al borde
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Row(
        children: [
          // Mostramos el título si existe
          if (title != null)
            Text(
              title!,
              style: textStyleTheme.titleLarge,
            ),
          // Creamos un spacer que ocupe el espacio restante
          const Spacer(),
          // Mostramos el subtitulo si existe
          if (subtitle != null)
            FilledButton.tonal(
              onPressed: () {},
              // Reducimos el tamaño del botón
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              child: Text(
                subtitle!,
                style: textStyleTheme.titleSmall,
              ),
            ),
        ],
      ),
    );
  }
}

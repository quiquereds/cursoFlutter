import 'dart:math';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

/// Creamos un Widget para mostrar el listado de películas favoritas en un GridView
/// estilo Masonry
class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;
  final bool showFavoriteButton;

  const MovieMasonry({
    super.key,
    required this.movies,
    this.loadNextPage,
    this.showFavoriteButton = true,
  });

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  // Creamos controladores para el scroll
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      // Si no se especificó función de carga, salimos de la función
      if (widget.loadNextPage == null) return;

      widget.loadNextPage!();

      // Determinamos la posición actual y la posición máxima
      final currentPosition = scrollController.position.pixels;
      final maxScroll = scrollController.position.maxScrollExtent;

      // Determinamos si nos encontramos cerca del límite para ejecutar el callback
      if ((currentPosition + 100) >= maxScroll) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        // Asignamos el controller del scroll
        controller: scrollController,
        // Se definen las columnas del GridView
        crossAxisCount: 3,
        itemCount: widget.movies.length,
        // Espacio horizontal y vertical entre items
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemBuilder: (context, index) {
          // Extraemos el índice actual de la película
          final Movie movie = widget.movies[index];

          /// Al primer indice le añadimos un espacio en blanco antes de la
          /// columna de películas para darle un aspecto desordenado al GridView
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 30),
                MoviePosterLink(
                  movie: movie,
                  showFavoriteButton: widget.showFavoriteButton,
                ),
              ],
            );
          }

          // Los demás indices se renderizan normal
          return MoviePosterLink(
            movie: movie,
            showFavoriteButton: widget.showFavoriteButton,
          );
        },
      ),
    );
  }
}

// Contenedor del poster de la película
class MoviePosterLink extends ConsumerWidget {
  final Movie movie;
  final bool showFavoriteButton;

  const MoviePosterLink(
      {super.key, required this.movie, required this.showFavoriteButton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tomamos la instancia del FutureProvider (isFavoriteProvider)
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    // Creamos una instancia de Math Random
    final random = Random();

    return FadeInUp(
      // Usamos una instancia random para aleatorizar la animación de entrada
      // El valor es >= 80 y <= 180
      from: random.nextInt(100) + 80,
      delay: Duration(milliseconds: random.nextInt(450) + 0),
      child: GestureDetector(
        onTap: () => context.push('/movie/${movie.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              // Shimmer
              FadeInImage(
                height: 200,
                fit: BoxFit.cover,
                placeholder:
                    const AssetImage('lib/assets/loaders/shimmerEffect.gif'),
                image: NetworkImage(movie.posterPath),
              ),
              if (showFavoriteButton)
                Positioned(
                  right: 6,
                  top: 6,
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
        ),
      ),
    );
  }
}

class BlurredIconButton extends StatelessWidget {
  final Widget icon;
  final double width;
  final double height;
  final double borderRadius;
  final BoxShape buttonShape;
  final Color blurColor;
  final void Function() onTap;

  const BlurredIconButton({
    super.key,
    required this.icon,
    required this.width,
    required this.height,
    this.buttonShape = BoxShape.rectangle,
    required this.blurColor,
    required this.onTap,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        onTap();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: buttonShape,
              color: blurColor,
            ),
            child: icon,
          ),
        ),
      ),
    );
  }
}

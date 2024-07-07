import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

/// Creamos un Widget para mostrar el listado de películas favoritas en un GridView
/// estilo Masonry
class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MovieMasonry({
    super.key,
    required this.movies,
    this.loadNextPage,
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
                MoviePosterLink(movie: movie),
              ],
            );
          }

          // Los demás indices se renderizan normal
          return MoviePosterLink(movie: movie);
        },
      ),
    );
  }
}

// Contenedor del poster de la película
class MoviePosterLink extends ConsumerWidget {
  final Movie movie;

  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tomamos la instancia del FutureProvider (isFavoriteProvider)
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    return FadeInUp(
      child: GestureDetector(
        onTap: () => context.push('/movie/${movie.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Image.network(movie.posterPath),
              Align(
                alignment: Alignment.topRight,
                child: IconButton.filledTonal(
                  onPressed: () async {
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

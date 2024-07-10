import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// FutureProvider que actualiza el estado una vez que se resuelve
// Recibe como argumento un valor
final similarMoviesProvider = FutureProvider.family((ref, int movieId) {
  // Creamos una referencia al repositorio
  final movieRepository = ref.watch(movieRepositoryProvider);

  return movieRepository.getSimilarMovies(movieId);
});

class SimilarMovies extends ConsumerWidget {
  final int movieId;

  const SimilarMovies({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Accedemos al estado del FutureProvider
    final similarMoviesFuture = ref.watch(similarMoviesProvider(movieId));

    // Usamos el helper when para determinar el estado del provider y devolver un widget
    return similarMoviesFuture.when(
      // Cuando hay datos mostramos la lista de películas
      data: (movies) => _Recomendations(movies: movies),
      // Ante un error, mostramos un mensaje
      error: (_, __) => const Center(
        child: Text('No hay películas similares'),
      ),
      // Cuando se están cargando los datos, un círculo de carga
      loading: () => const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}

class _Recomendations extends StatelessWidget {
  final List<Movie> movies;

  const _Recomendations({required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 60),
      child: MovieHorizontalListview(
        movies: movies,
        title: 'Quizá te podría gustar...',
      ),
    );
  }
}

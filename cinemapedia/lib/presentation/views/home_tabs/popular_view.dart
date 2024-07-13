import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularView extends ConsumerWidget {
  static const String name = 'popular-view';

  const PopularView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuchamos el provider de las películas populares
    final popularMovies = ref.watch(popularMoviesProvider);

    // Si no hay películas, mostramos un círculo de progreso
    if (popularMovies.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        movies: popularMovies,
        showFavoriteButton: true,
        loadNextPage: () =>
            ref.read(popularMoviesProvider.notifier).loadNextPage(),
      ),
    );
  }
}

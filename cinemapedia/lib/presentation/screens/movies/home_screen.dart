import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  /// Creamos el nombre de la ruta
  static const String name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

/// Creamos el StatefulWidget en un ConsumerStatefulWidget para
/// tener acceso al ref del Provider
class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

// Cambiamos el State por un ConsumerState
class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    // Accedemos al notifier para cargar los datos
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    // Creamos una referencia al estado del listado de películas
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    // Creamos una referencia al provider del slideshow
    final slideshowMovies = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  // AppBar de la aplicación
                  const CustomAppbar(),
                  // Slideshow de las primeras 6 películas en cartelera
                  MoviesSlideshow(movies: slideshowMovies),
                  // Horizontal ListView de las películas en cartelera
                  MovieHorizontalListview(
                    title: 'En cartelera',
                    subtitle: 'Jueves 20',
                    movies: nowPlayingMovies,
                    loadNextPage: () {
                      ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage();
                    },
                  ),

                  MovieHorizontalListview(
                    title: 'Próximamente',
                    subtitle: 'En este mes',
                    movies: nowPlayingMovies,
                    loadNextPage: () {
                      ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage();
                    },
                  ),

                  MovieHorizontalListview(
                    title: 'Populares',
                    movies: nowPlayingMovies,
                    loadNextPage: () {
                      ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage();
                    },
                  ),

                  MovieHorizontalListview(
                    title: 'Mejor calificadas',
                    subtitle: 'Desde siempre',
                    movies: nowPlayingMovies,
                    loadNextPage: () {
                      ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage();
                    },
                  ),
                ],
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}

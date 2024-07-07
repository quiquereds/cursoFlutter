import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Creamos el StatefulWidget en un ConsumerStatefulWidget para
/// tener acceso al ref del Provider
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

// Cambiamos el State por un ConsumerState
class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    // Accedemos al notifier para cargar los datos
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    // Creamos una referencia al estado de las 4 listas de películas
    final bool initialLoading = ref.watch(initialLoadingProvider);
    // Si están vacias mostramos el loader
    if (initialLoading) return const FullScreenLoader();

    // Si no están vacias, se ejecuta todo lo siguiente:

    // Creamos una referencia al provider del slideshow
    final slideshowMovies = ref.watch(moviesSlideshowProvider);
    // Creamos una referencia al estado del listado de películas
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    // Creamos una referencia al estado del listado de populares
    final popularMovies = ref.watch(popularMoviesProvider);
    // Creamos una referencia al estado del listado de a continuación
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    // Creamos una referencia al estado del listado de mejor votadas
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    /// Añadimos un CustomScrollView que permite trabajar con Slivers, los
    /// cuales tienen ciertos controles al hacer scroll en la app.
    ///
    /// El objetivo es que el AppBar sea visible cuando se está desplazando
    /// hacia arriba
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          stretch: true,
          floating: true,
          //backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            // Usamos el TitlePadding para quitar el espacio a la izquierda
            titlePadding: EdgeInsets.zero,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  // Slideshow de las primeras 6 películas en cartelera
                  MoviesSlideshow(movies: slideshowMovies),
                  // Horizontal ListView de las películas en cartelera
                  MovieHorizontalListview(
                    title: 'En cartelera 🍿',
                    subtitle: 'Jueves 20',
                    movies: nowPlayingMovies,
                    loadNextPage: () {
                      ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage();
                    },
                  ),

                  MovieHorizontalListview(
                    title: 'Próximamente 🫣',
                    subtitle: 'En este mes',
                    movies: upcomingMovies,
                    loadNextPage: () {
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                    },
                  ),

                  MovieHorizontalListview(
                    title: 'Populares ⭐',
                    movies: popularMovies,
                    loadNextPage: () {
                      ref.read(popularMoviesProvider.notifier).loadNextPage();
                    },
                  ),

                  MovieHorizontalListview(
                    title: 'Mejor calificadas 🏆',
                    subtitle: 'Desde siempre',
                    movies: topRatedMovies,
                    loadNextPage: () {
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage();
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

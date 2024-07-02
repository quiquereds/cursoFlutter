import 'package:cinemapedia/config/constants/images.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Image.asset(
                cinemexLogo,
                scale: 0.5,
              ),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  // Creamos una referencia al estado de películas en memoria
                  final searchedMovies = ref.read(searchedMoviesProvider);
                  // Creamos una referencia al provider del query
                  final searchQuery = ref.read(searchQueryProvider);

                  /// Indicamos que el showSearch va a funcionar con objetos Movie
                  showSearch<Movie?>(
                    /// Asignamos el query de búsqueda que está en memoria, por defecto,
                    /// es un String vacío hasta que el usuario haga una consulta, el
                    /// valor se va a ir actualizando a la última búsqueda realizada.
                    query: searchQuery,
                    context: context,
                    delegate: SearchMovieDelegate(
                      // Mandamos las películas en memoria (si existen)
                      initialMovies: searchedMovies,
                      // Asignamos la función para buscar peliculas
                      searchMovie: ref
                          .read(searchedMoviesProvider.notifier)
                          .searchMoviesByQuery,
                    ),
                  ).then((movie) {
                    /// Como showSearch es un Future, tiene que devolver una promesa,
                    /// la cual aprovechamos para realizar la navegación con el uso
                    /// del then
                    if (movie == null) return;
                    context.push('/movie/${movie.id}');
                  });
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

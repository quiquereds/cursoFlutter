import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  static const name = 'favorites-view';

  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  // Creamos controladores para el scroll
  bool isLastPage = false;
  bool isLoading = false;

  void loadNextPage() async {
    // Si las banderas están activas, no se hace nada
    if (isLoading || isLastPage) return;

    // Actualizamos la bandera
    isLoading = true;

    // Carga la siguiente página de películas
    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();

    // Se vuelve a cambiar la bandera al dejar de cargar
    isLoading = false;

    // Determinamos si es la última página de películas para actualizar la otra bandera
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  void initState() {
    super.initState();
    // Mandamos a llamar al provider para que cargue la página de películas
    loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    // Creamos una variable para almacenar todas las películas usando el provider
    // Usamos el watch para estar al pendiente de los cambios en el provider
    final List<Movie> favoriteMovies =
        ref.watch(favoriteMoviesProvider).values.toList();

    // Si no hay listado de películas favoritas, se muestra un mensaje
    if (favoriteMovies.isEmpty) {
      return const CustomMessage();
    }

    return Scaffold(
      body: MovieMasonry(
        movies: favoriteMovies,
        // Pasamos el método como referencia
        loadNextPage: loadNextPage,
      ),
    );
  }
}

class CustomMessage extends StatelessWidget {
  const CustomMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textStyleTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Nada por aquí 🫣',
            style: textStyleTheme.titleLarge!.copyWith(fontSize: 30),
          ),
          const SizedBox(height: 10),
          const SizedBox(
            width: 300,
            child: Text(
              '¿Que tal si empezamos añadiendo tus películas favoritas?',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.tonal(
            onPressed: () => context.go('/'),
            child: const Text('Explorar películas'),
          ),
        ],
      ),
    );
  }
}

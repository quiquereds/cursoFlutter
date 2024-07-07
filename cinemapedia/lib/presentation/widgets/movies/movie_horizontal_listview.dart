import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyleTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Portada de la película
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                movie.posterPath,
                width: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }

                  return GestureDetector(
                    // Utilizamos la navegación mediante ID
                    onTap: () => context.push('/movie/${movie.id}'),
                    child: FadeIn(child: child),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 5),
          //* Título
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyleTheme.titleSmall,
            ),
          ),
          //* Rating
          MovieRating(
            popularity: movie.popularity,
            voteAverage: movie.voteAverage,
          )
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

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          /// Solo si el widget cuenta con titulo o subtitulo se renderiza
          /// el widget _Title
          if (title != null || subtitle != null)
            _Title(
              title: title,
              subtitle: subtitle,
            ),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return _Slide(movie: movies[index]);
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

                  return FadeIn(child: child);
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
          SizedBox(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star_half_sharp,
                  color: Colors.yellow.shade800,
                ),
                const SizedBox(width: 3),
                Text(
                  HumanFormats.number(movie.voteAverage),
                  style: textStyleTheme.bodyMedium
                      ?.copyWith(color: Colors.yellow.shade800),
                ),
                const Spacer(),
                Text(
                  HumanFormats.number(movie.popularity),
                  style: textStyleTheme.bodySmall,
                )
              ],
            ),
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
      margin: const EdgeInsets.symmetric(horizontal: 10),
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
              ),
            ),
        ],
      ),
    );
  }
}

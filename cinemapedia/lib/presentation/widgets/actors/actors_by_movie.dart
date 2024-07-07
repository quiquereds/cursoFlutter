import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const ActorsByMovie({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Creamos una referencia al estilo de la app
    final textStyleTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    // Creamos una referencia a la lista de actores por película
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    // Mientras no esté la película, mostramos un indicador de carga
    if (actorsByMovie[movieId] == null) {
      return Container(
        height: 100,
        margin: const EdgeInsets.only(bottom: 50),
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        // Control del tamaño del ListView
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actorsByMovie[movieId]!.length,
          itemBuilder: (context, index) {
            final actor = actorsByMovie[movieId]![index];

            return Row(
              children: [
                FadeInRight(
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.surfaceDim,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            child: FadeInImage(
                              width: 100,
                              fit: BoxFit.cover,
                              placeholder: const AssetImage(
                                  'lib/assets/loaders/shimmerEffect.gif'),
                              image: NetworkImage(actor.profilePath),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            // Control de ancho de columnas de texto
                            width: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  actor.name,
                                  maxLines: 2,
                                  style: textStyleTheme.titleMedium!.copyWith(
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  actor.character!,
                                  style: textStyleTheme.bodyMedium!.copyWith(
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}

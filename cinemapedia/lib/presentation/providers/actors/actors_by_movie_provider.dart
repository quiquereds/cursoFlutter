import 'package:cinemapedia/domain/entities/actor_entity.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/* 
  El funcionamiento de este provider es el siguiente

  {
    '505465' : <Actor>[],
    '505466' : <Actor>[],
    '505467' : <Actor>[],

    ...
  },

  Devolver un mapa de ID's de películas apuntando a un listado de Actores
*/

// Creamos un provider encargado de manejar la búsqueda de actores

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  // Creamos una referencia a la implementación que se encarga de buscar actores
  final actorsRepository = ref.watch(actorsRepositoryProvider);

  return ActorsByMovieNotifier(getActors: actorsRepository.getActorsByMovie);
});

// Creamos un callback personalizado para crear casos de uso
typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  // Pedimos el caso de uso
  final GetActorsCallback getActors;

  // Constructor del Notifier con mapa vacío
  ActorsByMovieNotifier({
    required this.getActors,
  }) : super({});

  // Llamamos a la implementación de la función que carga la lista de actores
  Future<void> loadActors(String movieId) async {
    /// Determinamos si el estado actual ya tiene cargada en caché la
    /// lista, en ese caso, se cancela la petición
    if (state[movieId] != null) return;

    // Si no está cargada la lista, se hace la petición
    final List<Actor> actors = await getActors(movieId);

    // Hacemos la actualización del estado
    state = {...state, movieId: actors};
  }
}

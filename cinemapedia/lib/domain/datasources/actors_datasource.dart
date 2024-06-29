import 'package:cinemapedia/domain/entities/actor_entity.dart';

abstract class ActorsDatasource {
  // Definimos el método para obtener la lista de actores por película
  Future<List<Actor>> getActorsByMovie(String movieId);
}

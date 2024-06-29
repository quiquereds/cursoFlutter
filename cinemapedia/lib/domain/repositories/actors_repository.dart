import 'package:cinemapedia/domain/entities/actor_entity.dart';

/// El objetivo del repositorio es mandar a llamar al datasource a través de
/// este, y permitir específicar de qué datasource vendrán los datos

abstract class ActorsRepository {
  // Definimos el método para obtener la lista de actores por película
  Future<List<Actor>> getActorsByMovie(String movieId);
}

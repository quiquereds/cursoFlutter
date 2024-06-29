import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor_entity.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

// El repositorio es el encargado de mandar a traer los datos
class ActorRepositoryImpl extends ActorsRepository {
  // Requerimos el Datasource
  final ActorsDatasource datasource;

  // Creamos el constructor
  ActorRepositoryImpl(this.datasource);

  // Vinculamos el método con el datasource
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) =>
      datasource.getActorsByMovie(movieId);
}

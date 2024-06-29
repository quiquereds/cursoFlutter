// Este será el provider encargado de inicializar el repositorio de
// datos.

import 'package:cinemapedia/infrastructure/datasources/actordb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider((ref) {
  // Inicializamos el repositorio con el Datasource de TheMovieDB
  /// Si el repositorio de datos cambia, solo se tiene que cambiar el
  /// datasource

  return ActorRepositoryImpl(ActorMovieDbDatasource());
});

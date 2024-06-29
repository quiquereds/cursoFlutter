import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor_entity.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

// Implementamos la clase ActorsDatasource para trabajar con TheMovieDB
class ActorMovieDbDatasource extends ActorsDatasource {
  /// Creamos una instancia de Dio (para trabajar con peticiones HTTP)
  /// a nivel de propiedad de la clase para que todos los métodos tengan
  /// acceso a esta instancia.
  final dio = Dio(
    /// Creamos una URL base precargada para evitar estar mandando la
    /// misma base
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      // Añadimos los parámetros necesarios de petición
      queryParameters: {
        // Definimos la llave API
        'api_key': Environment.theMovieDbKey,
        // Definimos el lenguaje de los resultados
        'language': 'es-MX',
        // Definimos la región
        'region': 'MX',
      },
    ),
  );

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    /// Creamos la variable response donde se va a guardar la respuesta
    /// de la petición HTTP al endpoint 'credits' con el ID de la película
    final response = await dio.get('/movie/$movieId/credits');

    // Pasamos el mapa de la respuesta a una entidad de respuesta
    final castResponse = CreditsResponse.fromMap(response.data);

    // Barremos cada actor del cast y lo convertimos a la entidad Actor
    List<Actor> actors = castResponse.cast.map((cast) {
      return ActorMapper.castDBToEntity(cast);
    }).toList();

    return actors;
  }
}

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

/// Implementamos la clase de MoviesDatasource para obtener los datos
/// desde TheMovieDB
class MoviedbDatasource extends MoviesDatasource {
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

  // Implementamos el método para obtener las películas en cartelera
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    /// Creamos la variable response donde se va a guardar la respuesta
    /// de la petición HTTP al endpoint 'now_playing' con el queryParameter
    /// de la página.
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {
        'page': page,
      },
    );

    // Transformamos el JSON a una respuesta MovieDB (objeto)
    final movieDBResponse = MovieDbResponse.fromMap(response.data);

    /// Convertimos cada respuesta a la entidad Movie con el mapper
    /// y las pasamos a lista.
    final List<Movie> movies = movieDBResponse.results

        /// Aplicamos un filtro para que no se incluyan las películas
        /// que no tienen poster
        .where((moviedb) => moviedb.posterPath != 'file:///no-poster')
        .map((e) => MovieMapper.movieDBToEntity(e))
        .toList();

    // Devolvemos el listado
    return movies;
  }
}

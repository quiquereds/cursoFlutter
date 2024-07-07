import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
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

  // Creamos un método para devolver una lista de películas
  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    // Transformamos el JSON a una respuesta MovieDB (objeto)
    final movieDBResponse = MovieDbResponse.fromMap(json);

    /// Convertimos cada respuesta a la entidad Movie con el mapper
    /// y las pasamos a lista.
    final List<Movie> movies = movieDBResponse.results

        /// Aplicamos un filtro para que no se incluyan las películas
        /// que no tienen poster
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((movieDb) => MovieMapper.movieDBToEntity(movieDb))
        .toList();

    // Quitamos las películas que se tengan no-poster
    movies.removeWhere((movie) =>
        movie.posterPath == 'no-poster' || movie.backdropPath == 'no-poster');

    return movies;
  }

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

    // Llamamos al método para transformar el JSON a una lista de Movie
    return _jsonToMovies(response.data);
  }

  // Implementamos el método para obtener las películas populares
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    /// Creamos la variable response donde se va a guardar la respuesta
    /// de la petición HTTP al endpoint 'popular' con el queryParameter
    /// de la página.
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {
        'page': page,
      },
    );

    // Llamamos al método para transformar el JSON a una lista de Movie
    return _jsonToMovies(response.data);
  }

  // Implementamos el método para obtener las películas a continuación
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    /// Creamos la variable response donde se va a guardar la respuesta
    /// de la petición HTTP al endpoint 'popular' con el queryParameter
    /// de la página.
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {
        'page': page,
      },
    );

    // Llamamos al método para transformar el JSON a una lista de Movie
    return _jsonToMovies(response.data);
  }

  // Implementamos el método para obtener las películas a continuación
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    /// Creamos la variable response donde se va a guardar la respuesta
    /// de la petición HTTP al endpoint 'popular' con el queryParameter
    /// de la página.
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {
        'page': page,
      },
    );

    // Llamamos al método para transformar el JSON a una lista de Movie
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieByID(String id) async {
    /// Creamos la variable response donde se va a guardar la respuesta
    /// de la petición HTTP al endpoint para obtener información de una
    /// película en particular
    final response = await dio.get(
      '/movie/$id',
    );

    // Determinamos si existen resultados
    if (response.statusCode != 200) {
      throw Exception('Movie with id: $id not found');
    }

    // Mapeamos la respuesta al modelo de datos de MovieDBDetails
    final movieDB = MovieDbDetails.fromMap(response.data);

    // Convertimos el modelo a una entidad Movie de la app
    final Movie movie = MovieMapper.movieDbDetailsToEntity(movieDB);

    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) {
      // Si en la búsqueda está vacía, retornamos un arreglo vacío
      return [];
    } else {
      // Por otro lado, si la búsqueda no está vacía hacemos la petición
      /// Creamos la variable response donde se va a guardar la respuesta
      /// de la petición HTTP al endpoint de búsqueda de películas
      final response = await dio.get(
        '/search/movie',
        queryParameters: {
          'query': query,
        },
      );

      return _jsonToMovies(response.data);
    }
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId) async {
    /// Creamos la variable response donde se va a guardar la respuesta
    /// de la petición HTTP al endpoint similar.
    final response = await dio.get(
      '/movie/$movieId/similar',
    );

    return _jsonToMovies(response.data);
  }
}

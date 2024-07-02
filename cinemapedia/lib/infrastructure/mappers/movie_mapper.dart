import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

/// La misión de este mapper es leer distintos modelos de datos provenientes
/// de distintos DataSources para transformarlos a entidades de la aplicación
///
/// Es decir, es una capa de protección entre la entidad de la app y la respuesta
/// de fuera, un transformador por decirle asi.

class MovieMapper {
  // Creamos una función que va a transformar la respuesta a la entidad Movie
  static Movie movieDBToEntity(MovieMovieDB moviedb) {
    return Movie(
      adult: moviedb.adult,

      /// Validamos si el backdroppath no viene vacio para concatenar el id
      /// de la imagen proveniente de la respuesta con el endpoint
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/original${moviedb.backdropPath}'
          : 'https://ih1.redbubble.net/image.1893341687.8294/fposter,small,wall_texture,product,750x1000.jpg',

      /// Tomamos cada id de la lista de enteros para transformarlos a string
      /// y finalmente volverlo a pasar a lista
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
          : 'https://ih1.redbubble.net/image.1893341687.8294/fposter,small,wall_texture,product,750x1000.jpg',
      releaseDate: moviedb.releaseDate!,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount,
    );
  }

  // Creamos otro mapper para convertir un MovieDetails a una entidad Movie
  static Movie movieDbDetailsToEntity(MovieDbDetails moviedb) {
    return Movie(
      adult: moviedb.adult,

      /// Validamos si el backdroppath no viene vacio para concatenar el id
      /// de la imagen proveniente de la respuesta con el endpoint
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/original${moviedb.backdropPath}'
          : 'https://ih1.redbubble.net/image.1893341687.8294/fposter,small,wall_texture,product,750x1000.jpg',

      /// Tomamos cada nombre de género al que pertenece la película y lo
      /// convertimos a lista
      genreIds: moviedb.genres.map((e) => e.name).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
          : 'https://ih1.redbubble.net/image.1893341687.8294/fposter,small,wall_texture,product,750x1000.jpg',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount,
    );
  }
}

import 'package:isar/isar.dart';

// Creamos un part para la generación de código de la colección (IsarDB)
// con el comando 'dart run build_runner build'
part 'movie_entity.g.dart';

// Entidad de película
/// Regla de negocio de la estructura de datos de películas que
/// va a tener la aplicación

@collection // <- Anotamos la clase en una colección para trabajar con IsarDB
class Movie {
  // Creamos un identificador único para la base de datos de Isar
  // Lo marcamos como opcional para que Isar gestione el valor y el incremento por
  // defecto
  Id? isarId = Isar.autoIncrement;

  // Atributos
  final bool adult;
  final String backdropPath;
  final List<String> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  // Constructor
  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
}

import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// Creamos el DataSource específico del DataSource donde vendrán los datos
class IsarDatasource extends LocalStorageDatasource {
  /// Creamos la referencia a la base de datos de Isar
  /// Crear la referencia involucra una tarea asíncrona, donde se debe esperar a que se
  /// inicialice.
  late Future<Isar> db;

  // Creamos el constructor
  IsarDatasource() {
    // Abrimos la base de datos
    db = openDB();
  }

  // Creamos un método de apertura de la base de datos
  Future<Isar> openDB() async {
    /// Creamos una referencia al directorio donde se va a guardar la base de datos,
    /// se utiliza el paquete 'path_provider' para crear la referencia al directorio
    /// de documentos de la aplicación
    final dir = await getApplicationDocumentsDirectory();

    // Si no hay ninguna instancia, abrimos la base de datos
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        // Indicamos los esquemas (vienen del código generado con el build_runner)
        [MovieSchema],
        inspector: true,
        // Indicamos el directorio donde se ubicara la base de datos
        directory: dir.path,
      );
    }

    // Si ya hay una instancia, devolvemos la instancia
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    // Esperamos a que la base de datos ya esté inicializada con el método openDB()
    final isar = await db;

    /// Buscamos si en la base de datos existe una película con el id enviado como
    /// parámetro. Posterior al filter, se tienen acceso a las consultas, con el mismo
    /// nombre del atributo del objeto Movie, esto se debe al código generado por
    /// Dart automáticamente con el build_runner.
    ///
    /// Es decir, si en el objeto Movie, se cambia el nombre de un atributo, se debe
    /// volver a ejecutar el comando.
    final Movie? isFavoriteMovie =
        await isar.movies.filter().idEqualTo(movieId).findFirst();

    // Determinamos el valor booleano comprobando si la variable isFavoriteMovie es nula
    return isFavoriteMovie != null;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    // Buscamos si existe la película
    final favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    // Determinamos la acción dependiendo si se encontró la película o no
    if (favoriteMovie != null) {
      // Si la película está dentro de la base de datos local, se elimina (delete)
      // Se utiliza isarID porque es un valor único del registro en la colección
      return isar
          .writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
    }

    // Caso contrario, se añade la película a la colección (insert)
    return isar.writeTxnSync(() => isar.movies.putSync(movie));
  }

  @override
  Future<List<Movie>> loadFavoriteMovies({int limit = 10, offset = 0}) async {
    final isar = await db;

    /// Buscamos todas las películas que estén marcadas como favoritas cumpliendo con
    /// las condiciones del offset y el limit, estos dos conceptos pueden entenderse
    /// como la página y el número de películas por página.
    return isar.movies.where().offset(offset).limit(limit).findAll();
  }
}

// Creamos un repositorio que se va a encargar de inicializar el almacenamiento local
import 'package:cinemapedia/infrastructure/datasources/isar_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider(
  // Inicializamos el DataSource de Isar
  (ref) => LocalStorageRepositoryImpl(IsarDatasource()),
);

/// Creamos un FutureProvider que se encarga de retornar un Future, sirve para cuando
/// se debe cargar una tarea asíncrona, cuando esta finaliza, el estado del Provider
/// se crea y el UI es capaz de volver a renderizarse cuando se recibe el valor.
///
/// Se usa el Family para enviar un argumento al provider
final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  // Creamos una referencia al repositorio
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  // Escuchamos el LocalStorageProvider para ver si una película está en fav
  return localStorageRepository.isMovieFavorite(movieId);
});

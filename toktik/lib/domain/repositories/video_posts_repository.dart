import 'package:toktik/domain/entities/video_post.dart';

/// Creamos una clase abstracta del origen de datos de posts de videos
/// y será la responsable de gobernar los orígenes de datos
abstract class VideoPostRepository {
  /// Creamos una función que va a regresar una lista de VideoPost, la
  /// cual recibe un entero de la página
  Future<List<VideoPost>> getTrendingVideosByPage(int page);

  /// Creamos otra función que va a regresar una lista de VideoPost, que
  /// contendrá los videos favoritos del usuario.
  Future<List<VideoPost>> getFavoriteVideosByUser(String userId);
}

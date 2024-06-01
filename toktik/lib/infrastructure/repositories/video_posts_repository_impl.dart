import 'package:toktik/domain/datasources/video_posts_datasource.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/domain/repositories/video_posts_repository.dart';

/// La intención del repositorio, es que se comunique con un DataSource y
/// de esta forma sirva como capa de protección entre la aplicación y la
/// salida a los datos
class VideoPostsRepositoryImpl implements VideoPostRepository {
  // Requerimos el DataSource al momento de llamar al repositorio
  final VideoPostsDatasource videosDatasource;

  // Creamos el constructor de la clase
  VideoPostsRepositoryImpl({required this.videosDatasource});

  @override
  Future<List<VideoPost>> getFavoriteVideosByUser(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>> getTrendingVideosByPage(int page) {
    /// La función se encargará de comunicarse con el DataSource y devolver
    /// la lista de videos.
    return videosDatasource.getTrendingVideosByPage(page);
  }
}

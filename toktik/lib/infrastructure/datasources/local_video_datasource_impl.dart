import 'package:toktik/domain/datasources/video_posts_datasource.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/infrastructure/models/local_video_model.dart';
import 'package:toktik/shared/data/local_video_posts.dart';

class LocalVideoDatasource implements VideoPostsDatasource {
  @override
  Future<List<VideoPost>> getFavoriteVideosByUser(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>> getTrendingVideosByPage(int page) async {
    // Hacemos una simulación de petición a internet
    await Future.delayed(const Duration(seconds: 2));

    /// Utilizamos el método map del tipo de dato de lista para recorrer cada
    /// uno de los elementos dentro del listado
    final List<VideoPost> newVideos = videoPosts
        .map(
          /// Utilizamos el modelo de datos para mappear los datos JSON,
          /// pasarlos a una entidad de video y agruparlos en una lista
          (video) => LocalVideoModel.fromJson(video).toVideoPostEntity(),
        )
        .toList();

    // Retornamos la lista de videos
    return newVideos;
  }
}

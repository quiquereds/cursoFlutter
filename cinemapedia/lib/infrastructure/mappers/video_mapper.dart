import 'package:cinemapedia/domain/entities/video_entity.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_videos.dart';

/// Conversor de datos de Entidad Video de la respuesta de TheMovieDB
/// a una entidad de la regla de negocio de la aplicación

class VideoMapper {
  static moviedbVideoToEntity(Result moviedbVideo) => Video(
        id: moviedbVideo.id,
        name: moviedbVideo.name,
        youtubeKey: moviedbVideo.key,
        publishedAt: moviedbVideo.publishedAt,
      );
}

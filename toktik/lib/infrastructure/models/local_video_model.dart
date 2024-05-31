import 'package:toktik/domain/entities/video_post.dart';

class LocalVideoModel {
  // Atributos
  final String name;
  final String videoUrl;
  final int likes;
  final int views;

  // Constructor
  LocalVideoModel({
    required this.name,
    required this.videoUrl,
    this.likes = 0,
    this.views = 0,
  });

  // Constructor de JSON a Model
  factory LocalVideoModel.fromJson(Map<String, dynamic> json) =>
      LocalVideoModel(
        name: json['name'] ?? 'Not found',
        videoUrl: json['videoUrl'] ?? 'Not found',
        likes: json['likes'] ?? 0,
        views: json['views'] ?? 0,
      );

  // Constructor de Model a JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'videoUrl': videoUrl,
        'likes': likes,
        'views': views,
      };

  // Función para convertir a entidad (Mapper)
  VideoPost toVideoPostEntity() => VideoPost(
        caption: name,
        videoUrl: videoUrl,
        likes: likes,
        views: views,
      );
}

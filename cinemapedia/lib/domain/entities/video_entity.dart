// Entidad de video

// Regla de negocio de la estructura de datos de videos que
// va a tener la aplicación

class Video {
  final String id;
  final String name;
  final String youtubeKey;
  final DateTime publishedAt;

  Video({
    required this.id,
    required this.name,
    required this.youtubeKey,
    required this.publishedAt,
  });
}

// Creamos una clase que va a representar a cada video (objeto) de la app
class VideoPost {
  // Atributos de la clase
  final String caption;
  final String videoUrl;
  final int likes;
  final int views;

  // Constructor de la clase
  VideoPost({
    required this.caption,
    required this.videoUrl,
    this.likes = 0,
    this.views = 0,
  });
}

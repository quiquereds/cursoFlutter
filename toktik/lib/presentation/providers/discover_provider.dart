import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/domain/repositories/video_posts_repository.dart';

class DiscoverProvider extends ChangeNotifier {
  // Solicitamos un repositorio de videos para el provider
  final VideoPostRepository videosRepository;

  // Creamos el constructor
  DiscoverProvider({required this.videosRepository});

  // Bandera booleana que se encargará de cargar videos al iniciar la app
  bool initialLoading = true;

  // Lista con videos de la aplicación
  List<VideoPost> videos = [];

  Future<void> loadNextPage() async {
    /// Mandamos a llamar al repositorio para obtener los videos
    final newVideos = await videosRepository.getTrendingVideosByPage(1);

    // Añadimos los videos que obtuvimos a la lista
    videos.addAll(newVideos);

    // Actualizamos la bandera
    initialLoading = false;
    notifyListeners();
  }
}

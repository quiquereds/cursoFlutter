import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/infrastructure/models/local_video_model.dart';
import 'package:toktik/shared/data/local_video_posts.dart';

class DiscoverProvider extends ChangeNotifier {
  // TODO: Repositorio y Data Source

  // Bandera booleana que se encargará de cargar videos al iniciar la app
  bool initialLoading = true;

  // Lista con videos de la aplicación
  List<VideoPost> videos = [];

  Future<void> loadNextPage() async {
    /// Utilizamos el método map del tipo de dato de lista para recorrer cada
    /// uno de los elementos dentro del listado
    final List<VideoPost> newVideos = videoPosts
        .map(
          /// Utilizamos el modelo de datos para mappear los datos JSON,
          /// pasarlos a una entidad de video y agruparlos en una lista
          (video) => LocalVideoModel.fromJson(video).toVideoPostEntity(),
        )
        .toList();

    // Añadimos los videos que obtuvimos antes a la lista
    videos.addAll(newVideos);
    // Actualizamos la bandera
    initialLoading = false;
    notifyListeners();
  }
}

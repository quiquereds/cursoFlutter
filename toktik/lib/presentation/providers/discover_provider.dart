import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';

class DiscoverProvider extends ChangeNotifier {
  // Bandera booleana que se encargará de cargar videos al iniciar la app
  bool initialLoading = true;

  // Lista con videos de la aplicación
  List<VideoPost> videos = [];

  Future<void> loadNextPage() async {
    // todo: Cargar vidoes

    notifyListeners();
  }
}

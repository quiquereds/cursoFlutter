import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';

import 'movies_providers.dart';

/// Creamos un provider de solo lectura para hacer una sublista de las
/// películas en cartelera para el slideshow, de forma que solo se muestren
/// 6 de ellas

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  // Buscamos el provider de nowPlayingMoviesProvider
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  // Si la cartelera está vacía devolvemos un arreglo vacío
  if (nowPlayingMovies.isEmpty) return [];

  /// Cuando la lista de cartelera se carga, creamos una sublista para
  /// mostrar las 6 primeras películas en cartelera
  return nowPlayingMovies.sublist(0, 6);
});

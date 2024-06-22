import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Creamos un provider de solo lectura solo para determinar si los providers
/// que contienen las listas de peliculas ya tienen elementos

final initialLoadingProvider = Provider<bool>((ref) {
  // Determinamos si los 4 providers tienen datos
  // Creamos una referencia al estado del listado de películas
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  // Creamos una referencia al estado del listado de populares
  final step2 = ref.watch(popularMoviesProvider).isEmpty;
  // Creamos una referencia al estado del listado de a continuación
  final step3 = ref.watch(upcomingMoviesProvider).isEmpty;
  // Creamos una referencia al estado del listado de mejor votadas
  final step4 = ref.watch(topRatedMoviesProvider).isEmpty;

  /// Si los 4 providers están vacíos devolvemos un true para indicar
  /// que debe mostrarse el loader
  if (step1 || step2 || step3 || step4) return true;

  /// Por otro lado, si tienen datos, devolvemos un falso para mostrar el
  /// Home Screen
  return false;
});

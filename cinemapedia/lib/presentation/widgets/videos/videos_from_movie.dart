import 'package:cinemapedia/domain/entities/video_entity.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// FutureProvider
final FutureProviderFamily<List<Video>, int> videosFromMovieProvider =
    FutureProvider.family((ref, int movieId) {
  // Creamos una referencia al repositorio
  final movieRepository = ref.watch(movieRepositoryProvider);

  // Devolvemos los videos como Future
  return movieRepository.getYouTubeVideos(movieId);
});

class VideosFromMovie extends ConsumerWidget {
  final int movieId;

  const VideosFromMovie({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuchamos el provider
    final videosFromMovie = ref.watch(videosFromMovieProvider(movieId));

    // Usamos el when del provider para determinar qué mostrar en pantalla
    return videosFromMovie.when(
      data: (videos) => _VideosList(videos: videos),
      error: (_, __) => const Center(
        child: Text('No existen videos para esta película'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}

class _VideosList extends StatelessWidget {
  final List<Video> videos;

  const _VideosList({required this.videos});

  @override
  Widget build(BuildContext context) {
    // Si no hay que mostrar
    if (videos.isEmpty) {
      return const SizedBox();
    }

    return _YouTubeVideoPlayer(
      youtubeId: videos.first.youtubeKey,
      name: videos.first.name,
    );
  }
}

class _YouTubeVideoPlayer extends StatefulWidget {
  final String youtubeId;
  final String name;

  const _YouTubeVideoPlayer({
    required this.youtubeId,
    required this.name,
  });

  @override
  State<_YouTubeVideoPlayer> createState() => __YouTubeVideoPlayerState();
}

class __YouTubeVideoPlayerState extends State<_YouTubeVideoPlayer> {
  // Controlador del reproductor de YouTube
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Inicialización del controller
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        showLiveFullscreenButton: false,
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: YoutubePlayer(controller: _controller),
    );
  }
}

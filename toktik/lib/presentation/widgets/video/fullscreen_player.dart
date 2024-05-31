import 'package:flutter/material.dart';
import 'package:toktik/presentation/widgets/video/gradient_background.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;

  const FullScreenPlayer({
    super.key,
    required this.videoUrl,
    required this.caption,
  });

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  // Creamos un controlador del video player
  late VideoPlayerController controller;

  // Ciclo de vida del widget
  @override
  void initState() {
    // Siempre se inicializa primero el widget
    super.initState();

    // Se inicializa el controlador
    controller = VideoPlayerController.asset(widget.videoUrl)
      ..setVolume(0)
      ..setLooping(true)
      ..play();
  }

  @override
  void dispose() {
    // Hacemos la limpieza del widget
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        }

        /// Usamos un GestureDetector para controlar el video al tocar en
        /// la pantalla
        return GestureDetector(
          onTap: () {
            setState(() {
              if (controller.value.isPlaying) {
                controller.pause();
                return;
              }

              controller.play();
            });
          },

          /// El widget de AspectRatio permite que el children (en este caso
          /// el reproductor de video) conserve sus proporciones y no se
          /// deforme al ajustarse al dipositivo.
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(
              children: [
                // Reproductor de video
                VideoPlayer(controller),

                // Gradiente
                GradientBackground(
                  stops: const [0.8, 1.0],
                ),

                // Caption
                Positioned(
                  bottom: 50,
                  left: 20,
                  child: _VideoCaption(
                    caption: widget.caption,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _VideoCaption extends StatelessWidget {
  final String caption;

  const _VideoCaption({required this.caption});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return SizedBox(
      width: size.width * 0.6,
      child: Text(
        caption,
        maxLines: 2,
        style: titleStyle,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/widgets/shared/video_scrollable_view.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Colocamos la referencia al provider en modo watch para renderizar si
    /// hay cambios en la lista
    final discoverProvider = context.watch<DiscoverProvider>();

    return Scaffold(

        /// Creamos una condicional para detectar si el provider está cargando
        /// datos para mostrar un circulo de progreso en caso verdadero, o,
        /// propiamente los videos en pantalla en caso de que ya los tenga
        body: discoverProvider.initialLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : VideoScrollableView(videos: discoverProvider.videos));
  }
}

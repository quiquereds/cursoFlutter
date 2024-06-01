import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/config/theme/app_theme.dart';
import 'package:toktik/infrastructure/datasources/local_video_datasource_impl.dart';
import 'package:toktik/infrastructure/repositories/video_posts_repository_impl.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/screens/discover/discover_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Asignamos que de momento, el repositorio va a acceder a los videos locales
    final videoPostRepository =
        VideoPostsRepositoryImpl(videosDatasource: LocalVideoDatasource());

    // Hacemos accesible el provider a nivel global de la aplicación
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          /// Por defecto en los providers, se crean las instancias hasta que es
          /// necesario, inicializandose de esta manera de forma perezosa, para
          /// brincarse esto, la bandera de lazy, se debe colocar en false si se
          /// desea que se lance el constructor de forma inmediata.
          lazy: false,
          create: (_) => DiscoverProvider(videosRepository: videoPostRepository)
            ..loadNextPage(),
        )
      ],
      child: MaterialApp(
        title: 'TokTik',
        debugShowCheckedModeBanner: false,
        // Mandamos a llamar al método de nuestra clase AppTheme
        theme: AppTheme().getTheme(),
        home: const DiscoverScreen(),
      ),
    );
  }
}

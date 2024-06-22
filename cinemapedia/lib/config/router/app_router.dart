// Router de la aplicación
import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  // Definimos la ruta inicial
  initialLocation: '/',
  // Configuración de rutas
  routes: [
    // Ruta home
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),

      /// Configuramos las rutas hijas
      ///
      /// Estas son muy útiles a la hora de configurar el DeepLinking ya que
      /// permitirá al usuario volver a la ruta padre si llegó directamente con
      /// el URL, de no configurar estas rutas, el botón para regresar a
      /// inicio no saldría en la interfaz y volvería confusa la navegación
      /// para el usuario.
      routes: [
        GoRoute(
          // El :id representa un parámetro
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            // Obtenemos el ID de la película
            final movieID = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieID);
          },
        ),
      ],
    ),
  ],
);

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
    ),
  ],
);

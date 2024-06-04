import 'package:go_router/go_router.dart';
// Importamos nuestro archivo barril
import 'package:widgets_app/presentation/screens/screens.dart';

// Creamos el router de la aplicación
final appRouter = GoRouter(
  // Definimos la ruta inicial
  initialLocation: '/',
  routes: [
    // Configuramos la ruta home
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    // Configuramos las rutas existentes en la aplicación
    GoRoute(
      path: '/cards',
      builder: (context, state) => const CardsScreen(),
    ),
    GoRoute(
      path: '/buttons',
      builder: (context, state) => const ButtonsScreen(),
    ),
  ],
);

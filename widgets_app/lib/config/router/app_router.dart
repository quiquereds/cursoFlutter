import 'package:go_router/go_router.dart';
// Importamos nuestro archivo barril
import 'package:widgets_app/presentation/screens/screens.dart';

// Creamos el router de la aplicación
final appRouter = GoRouter(
  // Definimos la ruta inicial
  initialLocation: '/',
  // Hacemos la configuración de rutas por nombre
  routes: [
    // Configuramos la ruta home
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    // Configuramos las rutas existentes en la aplicación
    GoRoute(
      path: '/cards',
      name: CardsScreen.name,
      builder: (context, state) => const CardsScreen(),
    ),
    GoRoute(
      path: '/buttons',
      name: ButtonsScreen.name,
      builder: (context, state) => const ButtonsScreen(),
    ),
  ],
);

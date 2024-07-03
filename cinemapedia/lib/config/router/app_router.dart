// Router de la aplicación
import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/home_tabs/categories_view.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  // Definimos la ruta inicial
  initialLocation: '/',
  // Configuración de rutas
  routes: <RouteBase>[
    // Implementación de navegación con estado a través de un indexedStack
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        /// Se retorna el widget que implementa la navegación. El StatefulNavigationShell
        /// se pasa como argumento a HomeScreen para que se pueda acceder al estado del
        /// shell y navegar a otras ramas conservando el estado.
        ///
        /// A lo anterior, quiere decir que si en una vista hacemos scroll dentro de un
        /// ListView y navegamos a otra rama, el scroll del ListView no se va a perder,
        /// o más bien, no se va a reconstruir el widget cuando volvamos a la rama anterior
        /// conservando el estado del scroll
        return HomeScreen(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        // La ruta al primer tab del navigation bar (home)
        StatefulShellBranch(
          routes: <RouteBase>[
            // La vista raíz a mostrar en el primer tab
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeView(),
              routes: <RouteBase>[
                /// Configuración de las rutas hijas, la navegación a ellas va a cubrir
                /// la vista raíz, pero no el shell de la aplicación (barra de navegación)
                ///
                /// Las rutas hijas son útiles a la hora de configurar el DeepLinking ya que
                /// permitirá al usuario volver a la ruta padre si llegó directamente con
                /// el URL, de no configurar estas rutas, el botón para regresar a
                /// inicio no saldría en la interfaz y volvería confusa la navegación
                /// para el usuario.
                GoRoute(
                  // El :id representa un parámetro
                  path: 'movie/:id',
                  name: MovieScreen.name,
                  builder: (context, state) {
                    // Obtenemos el ID de la película a través del estado
                    final movieID = state.pathParameters['id'] ?? 'no-id';
                    return MovieScreen(movieId: movieID);
                  },
                ),
              ],
            ),
          ],
        ),

        // La ruta al segundo tab del navigation bar (categories)
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/categories',
              builder: (context, state) => const CategoriesView(),
            )
          ],
        ),

        // La ruta al tercer tab del navigation bar
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoritesView(),
            )
          ],
        ),
      ],
    )
  ],
);

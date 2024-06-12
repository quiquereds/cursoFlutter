import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Creamos una clase para gestionar los slides
class SlideInfo {
  // Atributos
  final String title;
  final String caption;
  final String imageUrl;

  // Constructor
  const SlideInfo({
    required this.title,
    required this.caption,
    required this.imageUrl,
  });
}

// Creamos la información de nuestros slides
final List<SlideInfo> slides = [
  const SlideInfo(
    title: 'Busca la comida',
    caption:
        'In pariatur deserunt est aute exercitation laborum laboris cupidatat elit.',
    imageUrl: 'assets/images/1.png',
  ),
  const SlideInfo(
    title: 'Entrega rápida',
    caption:
        'Cillum non fugiat eu magna aute non adipisicing cupidatat ea ullamco in ad culpa.',
    imageUrl: 'assets/images/2.png',
  ),
  const SlideInfo(
    title: 'Disfruta la comida',
    caption: 'Proident do anim in labore.',
    imageUrl: 'assets/images/3.png',
  ),
];

class AppTutorialScreen extends StatefulWidget {
  static const name = 'tutorial_screen';

  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {
  // Creamos un controlador inicializado del PageView
  final PageController pageViewController = PageController();

  /// Creamos una bandera para determinar si el usuario se encuentra en
  /// el último slide
  bool endReached = false;

  @override
  void initState() {
    super.initState();

    /// Creamos un listener para determinar en qué posición de los slides
    /// se encuentra el usuario
    pageViewController.addListener(() {
      // Asignamos la posición actual en page con inicializador en 0
      final page = pageViewController.page ?? 0;

      /// Si no se ha llegado al final y la posición está proxima al final
      /// de la lista de slides, se actualiza la bandera
      if (!endReached && page >= (slides.length - 1.5)) {
        setState(() {
          endReached = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // Liberamos la memoria elíminando el listener
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Accedemos al tema de la aplicación
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Listado de slides
          PageView(
            // Física de desplazamiento o scroll
            physics: const BouncingScrollPhysics(),

            // Vinculamos el controller
            controller: pageViewController,

            /// Devolvemos como children una lista de _Slide a partir del mapeo
            /// de la lista slides
            children: slides
                .map(
                  (slideData) => _Slide(
                    title: slideData.title,
                    caption: slideData.caption,
                    imageUrl: slideData.imageUrl,
                  ),
                )
                .toList(),
          ),

          // Botón de omitir
          Positioned(
            right: 20,
            top: 50,
            child: TextButton(
              onPressed: () => context.pop(),
              child: const Text('Salir'),
            ),
          ),

          // Indicador de página
          Positioned(
            bottom: 30,
            left: 30,
            child: SmoothPageIndicator(
              controller: pageViewController,
              count: slides.length,
              onDotClicked: (index) {
                pageViewController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                );
              },
              effect: SwapEffect(
                activeDotColor: colors.primary,
                dotColor: Colors.black26,
              ),
            ),
          ),

          /// Botón de continuar (se muestra si se cumple la condición del
          /// initState
          endReached
              ? Positioned(
                  bottom: 15,
                  right: 30,
                  child: FadeInRight(
                    from: 15,
                    delay: const Duration(seconds: 1),
                    child: FilledButton(
                      onPressed: () => context.pop(),
                      child: const Text('Empezar'),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

// Creamos el widget del slide

class _Slide extends StatelessWidget {
  final String title;
  final String caption;
  final String imageUrl;

  const _Slide({
    required this.title,
    required this.caption,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageUrl),
            const SizedBox(height: 20),
            Text(
              title,
              style: titleStyle,
            ),
            const SizedBox(height: 10),
            Text(
              caption,
              style: captionStyle,
            ),
          ],
        ),
      ),
    );
  }
}

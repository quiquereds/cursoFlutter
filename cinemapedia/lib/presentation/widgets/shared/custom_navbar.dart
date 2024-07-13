import 'dart:ui';

import 'package:cinemapedia/config/helpers/size_config.dart';
import 'package:cinemapedia/presentation/clippers/reflector_indicator_clipper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class CustomBottomNavigation extends StatelessWidget {
  // Recibimos el shell como argumento
  final StatefulNavigationShell navigationShell;

  const CustomBottomNavigation({
    super.key,
    required this.navigationShell,
  });

  // Creamos un método para alternar entre vistas mediante un switch
  void onItemTap(BuildContext context, int index) {
    /// Alternamos entre vistas mediante el método goBranch, este método
    /// garanriza que se restaure el último estado de navegación para la
    /// rama
    navigationShell.goBranch(
      index,
      // Soporte para ir a la ubicación inicial de la rama.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Inicializamos las medidas de la aplicación
    AppSizes().initSizes(context);

    // Color del scaffold
    final Color scaffoldColor = Theme.of(context).scaffoldBackgroundColor;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSizes.blockSizeHorizontal * 4.5,
        0,
        AppSizes.blockSizeHorizontal * 4.5,
        50,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: AppSizes.screenWidth,
            height: AppSizes.blockSizeHorizontal * 18,
            decoration: BoxDecoration(
              color: scaffoldColor.withAlpha(400),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              children: [
                // * Lista de iconos
                Positioned(
                  bottom: 0,
                  top: 0,
                  left: AppSizes.blockSizeHorizontal * 3,
                  right: AppSizes.blockSizeHorizontal * 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BottomNavBtn(
                        icon: IconlyLight.home,
                        currentIndex: navigationShell.currentIndex,
                        index: 0,
                        onTap: (selectedIndex) {
                          onItemTap(context, selectedIndex);
                        },
                      ),
                      BottomNavBtn(
                        icon: IconlyLight.star,
                        currentIndex: navigationShell.currentIndex,
                        index: 1,
                        onTap: (selectedIndex) {
                          onItemTap(context, selectedIndex);
                        },
                      ),
                      BottomNavBtn(
                        icon: IconlyLight.bookmark,
                        currentIndex: navigationShell.currentIndex,
                        index: 2,
                        onTap: (selectedIndex) {
                          onItemTap(context, selectedIndex);
                        },
                      ),
                    ],
                  ),
                ),

                // * Reflector (indicador de índice actual)
                AnimatedPositioned(
                  left: animatedPositionedValue(navigationShell.currentIndex),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.decelerate,
                  child: Column(
                    children: [
                      /// Indicador
                      Container(
                        height: AppSizes.blockSizeHorizontal * 1.0,
                        width: AppSizes.blockSizeHorizontal * 12,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // Reflector
                      ClipPath(
                        clipper: ReflectorClipper(),
                        child: Container(
                          height: AppSizes.blockSizeHorizontal * 15,
                          width: AppSizes.blockSizeHorizontal * 12,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.yellow.withOpacity(0.8),
                                Colors.yellow.withOpacity(0.3),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavBtn extends StatelessWidget {
  final IconData icon;
  final void Function(int) onTap;
  final int index;
  final int currentIndex;

  const BottomNavBtn({
    super.key,
    required this.icon,
    required this.onTap,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    AppSizes().initSizes(context);

    return InkWell(
      onTap: () {
        onTap(index);
      },
      child: Container(
        height: AppSizes.blockSizeHorizontal * 13,
        width: AppSizes.blockSizeHorizontal * 17,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Iconos de sombra
            (currentIndex == index)
                ? Positioned(
                    left: AppSizes.blockSizeHorizontal * 4,
                    bottom: AppSizes.blockSizeHorizontal * 1.5,
                    child: Icon(
                      icon,
                      color: Colors.black,
                      size: AppSizes.blockSizeHorizontal * 8,
                    ),
                  )
                : Container(),

            // Iconos activos (amarillos)
            AnimatedOpacity(
              opacity: (currentIndex == index) ? 1 : 0.2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              child: Icon(
                icon,
                color: Colors.yellow[300],
                size: AppSizes.blockSizeHorizontal * 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Esta función se encarga de recibir el índice actual, y de acuerdo
/// con este valor se regresa un valor flotante que representa la
/// posición en la que se debe colocar el índicador
double animatedPositionedValue(int currentIndex) {
  switch (currentIndex) {
    case 0:
      return AppSizes.blockSizeHorizontal * 11.15;
    case 1:
      return AppSizes.blockSizeHorizontal * 39.5;
    case 2:
      return AppSizes.blockSizeHorizontal * 67.8;
    default:
      return 0;
  }
}

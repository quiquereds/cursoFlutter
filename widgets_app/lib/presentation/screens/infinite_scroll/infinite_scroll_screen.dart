import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScreen extends StatefulWidget {
  static const name = 'infinite_screen';

  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {
  // Creamos un controller para el scroll del ListView
  final ScrollController scrollController = ScrollController();
  // Creamos una bandera para controlar si se está cargando el listado
  bool isLoading = false;
  // Creamos una bandera para revisar si el widget está montado
  bool isMounted = true;

  @override
  void initState() {
    super.initState();
    // Añadimos un listener del scroll para detectar la posición
    scrollController.addListener(() {
      /// Posición actual
      double actualPosition = scrollController.position.pixels;

      /// Posición límite de scroll
      double maxScroll = scrollController.position.maxScrollExtent;

      /// Damos un threshold para detectar cuando nos aproximamos al borde
      if ((actualPosition + 500) >= maxScroll) {
        // Cargar siguiente listado
        loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    // Limpiamos el scrollController
    scrollController.dispose();
    // Desmontamos el widget
    isMounted = false;
    super.dispose();
  }

  /// Método para desplazar el scroll automáticamente hacia abajo
  /// cuando se cargan nuevas imágenes
  void moveScrollToBottom() {
    /// Posición actual
    double actualPosition = scrollController.position.pixels;

    /// Posición límite de scroll
    double maxScroll = scrollController.position.maxScrollExtent;

    /// Si el usuario se encuentra 150 pixeles arriba del borde inferior
    /// la función no se ejecutará, ya que esto indica que el usuario
    /// está viendo algún contenido en la parte superior.
    if ((actualPosition + 150) <= maxScroll) return;

    /// Si el usuario se encuentra cerca del borde, se anima el scroll
    /// a una posición 120 pixeles más abajo de la posición actual del usuario
    scrollController.animateTo(
      actualPosition + 120,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future loadNextPage() async {
    // Si se está cargando el listado, salimos de la función
    if (isLoading) return;
    // Si no se está cargando nada actualmente, cambiamos la bandera
    isLoading = true;
    setState(() {});
    // Simulamos una espera
    await Future.delayed(const Duration(seconds: 2));
    // Añadimos más imágenes al listado
    addMoreImages();
    // Volvemos a cambiar la bandera
    isLoading = false;

    /// Verificamos si el widget sigue en memoria para llamar al setState,
    /// si está montado, no hacemos la llamada a setState.
    if (!isMounted) return;
    setState(() {});
    // Nos desplazamos hacia abajo
    moveScrollToBottom();
  }

  // Creamos una lista para almacenar los IDs de imagen
  List<int> imagesIds = [1, 2, 3, 4, 5];

  // Creamos un método para agregar imágenes al arreglo anterior
  void addMoreImages() {
    // Capturamos el último valor
    final lastId = imagesIds.last;

    imagesIds.addAll(
      /// Agregamos los siguientes 5 números consecutivos a la lista
      /// anterior
      ///
      /// lastId = 7
      /// -> lastId + 1, lastId + 2, lastId + 3 ...
      [1, 2, 3, 4, 5].map((e) => lastId + e),
    );
  }

  Future<void> onRefresh() async {
    // Actualizamos la bandera
    isLoading = true;
    setState(() {});

    // Simulamos una espera
    await Future.delayed(const Duration(seconds: 2));

    // Verficamos si el widget sigue activo
    if (!mounted) return;

    // Actualizamos la bandera después del trabajo asíncrono
    isLoading = false;

    // Obtenemos el id de la última imágen en el arreglo
    final lastId = imagesIds.last;

    // Limpiamos el arreglo de imágenes
    imagesIds.clear();

    // Añadimos la imágen con índice siguiente
    imagesIds.add(lastId + 1);

    // Cargamos las siguientes 5 imagenes
    addMoreImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      /// Utilizamos el MediaQuery para remover espacios de información o de
      /// navegación del teléfono
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: RefreshIndicator(
          onRefresh: onRefresh,
          edgeOffset: 10,
          strokeWidth: 2,
          child: ListView.builder(
            controller: scrollController,
            // Hacemos un ListView  con la longitud del arreglo
            itemCount: imagesIds.length,
            itemBuilder: (context, index) {
              return FadeInImage(
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
                placeholder: const AssetImage('assets/images/jar-loading.gif'),
                image: NetworkImage(
                    'https://picsum.photos/id/${imagesIds[index]}/500/300'),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => !isLoading ? context.pop() : null,
        child: !isLoading
            ? FadeIn(child: const Icon(Icons.arrow_back_ios_new_rounded))
            : SpinPerfect(
                infinite: true,
                child: const Icon(Icons.refresh_rounded),
              ),
      ),
    );
  }
}

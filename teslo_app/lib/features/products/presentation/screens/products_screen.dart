import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:teslo_shop/features/products/presentation/providers/products_provider.dart';
import 'package:teslo_shop/features/products/presentation/widgets/widgets.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: const _ProductsView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nuevo producto'),
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class _ProductsView extends ConsumerStatefulWidget {
  const _ProductsView();

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      // Posición actual del scroll
      final position = scrollController.position.pixels;

      // Posición máxima del scroll
      final maxPosition = scrollController.position.maxScrollExtent;

      // Si la posición actual está cerca de la posición máxima cargamos la siguiente página
      if (position + 400 >= maxPosition) {
        ref.read(productsProvider.notifier).loadNextPage();
      }
    });

    ref.read(productsProvider.notifier).loadNextPage();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Creamos una referencia a nuestro provider de productos
    final productsState = ref.watch(productsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        physics: BouncingScrollPhysics(),
        controller: scrollController,
        crossAxisCount: 2, // Columnas,
        mainAxisSpacing: 20, // Espacio entre columnas,
        crossAxisSpacing: 35, // Espacio entre filas
        itemCount: productsState.products.length,
        itemBuilder: (context, index) {
          // Creamos una referencia al producto actual
          final product = productsState.products[index];

          return ProductCard(product: product);
        },
      ),
    );
  }
}

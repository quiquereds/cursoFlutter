import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'product_repository_provider.dart';

/// Provider para el estado de la lista de productos (STATE PROVIDER)
/// Este provider se encarga de proveer el estado de la lista de productos.
final productsProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductsNotifier(productsRepository: productsRepository);
});

/// Notificador de estado de la lista de productos (STATE NOTIFIER)
/// Este notificador se encarga de manejar el estado de [ProductsState]
/// y notificar a los consumidores de los cambios en el estado.
class ProductsNotifier extends StateNotifier<ProductsState> {
  /// Se solicita el repositorio de productos para obtener los productos
  final ProductsRepository productsRepository;

  // Inicializamos el estado de la lista de productos
  ProductsNotifier({
    required this.productsRepository,
  }) : super(ProductsState()) {
    // Cargamos la primera página de productos en cuanto se inicializa el notificador
    loadNextPage();
  }

  /// Método para cargar la siguiente página de productos
  Future loadNextPage() async {
    // Si ya se está cargando o ya se cargó la última página, no hacemos nada
    if (state.isLoading || state.isLastPage) return;

    // Actualizamos el estado para indicar que se está cargando
    state = state.copyWith(
      isLoading: true,
    );

    // Obtenemos los productos de la siguiente página
    final products = await productsRepository.getProductsByPage(
      limit: state.limit,
      offset: state.offset,
    );

    // Si no hay productos, actualizamos el estado para indicar que ya se cargó la última página
    if (products.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        isLastPage: true,
      );
      return;
    }

    // Actualizamos el estado con los productos obtenidos y el offset actualizado
    state = state.copyWith(
      isLoading: false,
      isLastPage: false,
      offset: state.offset + 10,
      // Agregamos los productos obtenidos a la lista de productos actual
      products: [...state.products, ...products],
    );
  }
}

/// Estado de la lista de productos (STATE PROVIDER)
class ProductsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Product> products;

  ProductsState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.products = const [],
  });

  /// Método copyWith para actualizar el estado de la lista de productos
  ProductsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Product>? products,
  }) =>
      ProductsState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        products: products ?? this.products,
      );
}

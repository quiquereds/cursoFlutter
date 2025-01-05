import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';

/// Provider para obtener la información de un producto
/// El modificador `autoDispose` indica que el provider se autodestruirá cuando no sea necesario
/// El modificador `family` indica que el provider es una familia de providers y que espera un argumento
/// El argumento que espera es el id del producto que se desea obtener
///
/// La firma del StateNotifierProvider es `<T, S, A>` donde:
/// - T es el tipo de StateNotifier que se utilizará
/// - S es el tipo de estado que manejará el StateNotifier
/// - A es el tipo de argumento que se espera (SOLO si es un provider de tipo familia)
///
/// Ahora no solo se tendrá acceso al ref, sino que también se tendrá acceso al argumento
/// que se le pase al provider, el cual se expresa dentro de la función.

final productProvider = StateNotifierProvider.autoDispose
    .family<ProductNotifier, ProductState, String>((ref, productId) {
  // Solicitamos el repositorio de productos
  final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductNotifier(
    productsRepository: productsRepository,
    productId: productId,
  );
});

/// Notificador de estado de la información de un producto
class ProductNotifier extends StateNotifier<ProductState> {
  // Solicitamos el repositorio de productos
  final ProductsRepository productsRepository;

  // Inicializamos el estado del producto
  ProductNotifier({
    required this.productsRepository,
    required String productId,
  }) : super(ProductState(id: productId)) {
    // Cargamos la información del producto
    loadProduct();
  }

  // Método para crear la información inicial de un producto nuevo
  Product newEmptyProduct() {
    return Product(
      id: 'new',
      title: '',
      price: 0,
      description: '',
      slug: '',
      stock: 0,
      sizes: [],
      gender: 'men',
      tags: [],
      images: [],
    );
  }

  // Método para cargar la información de un producto
  Future<void> loadProduct() async {
    /// Si el id es 'new', entonces se creará un nuevo producto
    try {
      if (state.id == 'new') {
        state = state.copyWith(
          product: newEmptyProduct(),
          isLoading: false,
        );
        return;
      }

      final product = await productsRepository.getProductById(state.id);

      state = state.copyWith(
        product: product,
        isLoading: false,
      );
    } catch (e) {
      // 404 Not Found
      print(e);
    }
  }
}

/// State de la información de un producto
class ProductState {
  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  // Método para sobre escribir el estado
  ProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) =>
      ProductState(
        id: id ?? this.id,
        product: product ?? this.product,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}

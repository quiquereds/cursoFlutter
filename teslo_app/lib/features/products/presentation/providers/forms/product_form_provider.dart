import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/shared/shared.dart';

// Provider para el formulario de producto
final productFormProvider = StateNotifierProvider.autoDispose
    .family<ProductFormNotifier, ProductFormState, Product>((ref, product) {
  return ProductFormNotifier(
    product: product,
  );
});

/// Notifier para el formulario de producto
class ProductFormNotifier extends StateNotifier<ProductFormState> {
  final void Function(Map<String, dynamic> productLike)? onSubmitCallback;

  /// Constructor del notifier del formulario de producto
  ProductFormNotifier({
    this.onSubmitCallback,
    required Product product,
  }) : super(
          ProductFormState(
            title: Title.dirty(product.title),
            slug: Slug.dirty(product.slug),
            price: Price.dirty(product.price),
            inStock: Stock.dirty(product.stock),
            id: product.id,
            sizes: product.sizes,
            gender: product.gender,
            description: product.description,
            tags: product.tags.join(', '),
            images: product.images,
          ),
        );

  /// Método para enviar el formulario
  Future<bool> onFormSubmit() async {
    _touchEveryField();

    if (!state.isFormValid) return false;
    if (onSubmitCallback == null) return false;

    final productLike = {
      'id': state.id,
      'title': state.title.value,
      'price': state.price.value,
      'description': state.description,
      'slug': state.slug.value,
      'stock': state.inStock.value,
      'sizes': state.sizes,
      'gender': state.gender,
      'tags': state.tags.split(','),
      'images': state.images
          .map((image) =>
              image.replaceAll('${Environment.apiUrl}/files/product/', ''))
          .toList()
    };

    return true; // TODO
  }

  /// Método para validar el formulario
  void _touchEveryField() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  /// Método para cambiar el título del producto
  void onTitleChanged(String value) {
    state = state.copyWith(
      title: Title.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  /// Método para cambiar el slug del producto
  void onSlugChanged(String value) {
    state = state.copyWith(
      slug: Slug.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  /// Método para cambiar el precio del producto
  void onPriceChanged(String value) {
    final double price = double.tryParse(value) ?? -1;

    state = state.copyWith(
      price: Price.dirty(price),
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(price),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  /// Método para cambiar el stock del producto
  void onStockChanged(String value) {
    final int stock = int.tryParse(value) ?? -1;

    state = state.copyWith(
      inStock: Stock.dirty(stock),
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(stock),
      ]),
    );
  }

  /// Método para cambiar las tallas del producto
  void onSizeChanged(List<String> value) {
    state = state.copyWith(sizes: value);
  }

  /// Método para cambiar el género del producto
  void onGenderChanged(String value) {
    state = state.copyWith(gender: value);
  }

  // Método para cambiar la descripción del producto
  void onDescriptionChanged(String value) {
    state = state.copyWith(description: value);
  }

  // Método para cambiar las etiquetas del producto
  void onTagsChanged(String value) {
    state = state.copyWith(tags: value);
  }
}

/// Estado inicial del formulario de producto
class ProductFormState {
  // Atributos del formulario
  final bool isFormValid;
  final String? id;
  final Title title;
  final Slug slug;
  final Price price;
  final List<String> sizes;
  final String gender;
  final Stock inStock;
  final String description;
  final String tags;
  final List<String> images;

  /// Constructor del estado inicial del formulario de producto con valores por defecto
  ProductFormState({
    this.isFormValid = false,
    this.id,
    this.title = const Title.dirty(''),
    this.slug = const Slug.dirty(''),
    this.price = const Price.dirty(0),
    this.sizes = const [],
    this.gender = 'men',
    this.inStock = const Stock.dirty(0),
    this.description = '',
    this.tags = '',
    this.images = const [],
  });

  /// Método para sobre escribir estado actual del formulario
  ProductFormState copyWith({
    bool? isFormValid,
    String? id,
    Title? title,
    Slug? slug,
    Price? price,
    List<String>? sizes,
    String? gender,
    Stock? inStock,
    String? description,
    String? tags,
    List<String>? images,
  }) =>
      ProductFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        price: price ?? this.price,
        sizes: sizes ?? this.sizes,
        gender: gender ?? this.gender,
        inStock: inStock ?? this.inStock,
        description: description ?? this.description,
        tags: tags ?? this.tags,
        images: images ?? this.images,
      );
}

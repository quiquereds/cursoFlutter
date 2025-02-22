import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class ProductScreen extends ConsumerWidget {
  final String productId;

  const ProductScreen({super.key, required this.productId});

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Producto guardado'),
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Instanciamos el provider de productos
    final productState = ref.watch(productProvider(productId));

    return GestureDetector(
      onTap: () {
        // Ocultamos el teclado al hacer tap en cualquier parte de la pantalla
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editar producto'),
          actions: [
            IconButton(
              onPressed: () async {
                final photoPath = await CameraGalleryServiceImpl().pickImage();
                if (photoPath == null) return;

                ref
                    .read(productFormProvider(productState.product!).notifier)
                    .updateProductImage(photoPath);
              },
              icon: Icon(Icons.photo_library_outlined),
            ),
            IconButton(
              onPressed: () async {
                final photoPath = await CameraGalleryServiceImpl().takePhoto();
                if (photoPath == null) return;

                ref
                    .read(productFormProvider(productState.product!).notifier)
                    .updateProductImage(photoPath);
              },
              icon: Icon(Icons.camera_alt_outlined),
            )
          ],
        ),
        body: productState.isLoading
            ? FullScreenLoader()
            : _ProductView(product: productState.product!),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Si el producto es nulo, no hacemos nada
            if (productState.product == null) return;

            // Enviamos el formulario
            ref
                .read(productFormProvider(productState.product!).notifier)
                .onFormSubmit()
                .then((value) {
              if (!value) return;
              if (context.mounted) showSnackbar(context);
            });
          },
          child: const Icon(Icons.save_as_outlined),
        ),
      ),
    );
  }
}

class _ProductView extends ConsumerWidget {
  final Product product;

  const _ProductView({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyles = Theme.of(context).textTheme;

    // Establecemos comunicación el formulario del producto
    final productForm = ref.watch(productFormProvider(product));

    return ListView(
      children: [
        SizedBox(
          height: 250,
          width: 600,
          child: _ImageGallery(images: productForm.images),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            productForm.title.value,
            style: textStyles.titleSmall,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        _ProductInformation(product: product),
      ],
    );
  }
}

class _ProductInformation extends ConsumerWidget {
  final Product product;
  const _ProductInformation({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Establecemos comunicación el formulario del producto
    final productForm = ref.watch(productFormProvider(product));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Generales'),
          const SizedBox(height: 15),
          CustomProductField(
            isTopField: true,
            label: 'Nombre',
            initialValue: productForm.title.value,
            onChanged:
                ref.read(productFormProvider(product).notifier).onTitleChanged,
            errorMessage: productForm.title.errorMessage,
          ),
          CustomProductField(
            label: 'Slug',
            initialValue: productForm.slug.value,
            onChanged:
                ref.read(productFormProvider(product).notifier).onSlugChanged,
            errorMessage: productForm.slug.errorMessage,
          ),
          CustomProductField(
            isBottomField: true,
            label: 'Precio',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: productForm.price.value.toString(),
            onChanged:
                ref.read(productFormProvider(product).notifier).onPriceChanged,
            errorMessage: productForm.price.errorMessage,
          ),
          const SizedBox(height: 15),
          const Text('Extras'),
          _SizeSelector(
            selectedSizes: productForm.sizes,
            onSizeChanged:
                ref.read(productFormProvider(product).notifier).onSizeChanged,
          ),
          const SizedBox(height: 5),
          _GenderSelector(
            selectedGender: productForm.gender,
            onGenderChanged:
                ref.read(productFormProvider(product).notifier).onGenderChanged,
          ),
          const SizedBox(height: 15),
          CustomProductField(
            isTopField: true,
            label: 'Existencias',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: productForm.inStock.value.toString(),
            onChanged:
                ref.read(productFormProvider(product).notifier).onStockChanged,
            errorMessage: productForm.inStock.errorMessage,
          ),
          CustomProductField(
            maxLines: 6,
            label: 'Descripción',
            keyboardType: TextInputType.multiline,
            initialValue: productForm.description,
            onChanged: ref
                .read(productFormProvider(product).notifier)
                .onDescriptionChanged,
          ),
          CustomProductField(
            isBottomField: true,
            maxLines: 2,
            label: 'Tags (Separados por coma)',
            keyboardType: TextInputType.multiline,
            initialValue: productForm.tags,
            onChanged:
                ref.read(productFormProvider(product).notifier).onTagsChanged,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _SizeSelector extends StatelessWidget {
  final List<String> selectedSizes;
  final void Function(List<String> selectedSizes) onSizeChanged;
  final List<String> sizes = const ['XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL'];

  const _SizeSelector({
    required this.selectedSizes,
    required this.onSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      emptySelectionAllowed: true,
      showSelectedIcon: false,
      segments: sizes.map((size) {
        return ButtonSegment(
            value: size,
            label: Text(size, style: const TextStyle(fontSize: 10)));
      }).toList(),
      selected: Set.from(selectedSizes),
      onSelectionChanged: (newSelection) {
        // Ocultamos el teclado al hacer tap en cualquier parte de la pantalla
        FocusScope.of(context).unfocus();
        onSizeChanged(List.from(newSelection));
      },
      multiSelectionEnabled: true,
    );
  }
}

class _GenderSelector extends StatelessWidget {
  final String selectedGender;
  final void Function(String selectedGender) onGenderChanged;
  final List<String> genders = const ['men', 'women', 'kid'];
  final List<IconData> genderIcons = const [
    Icons.man,
    Icons.woman,
    Icons.boy,
  ];

  const _GenderSelector({
    required this.selectedGender,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedButton(
        emptySelectionAllowed: false,
        multiSelectionEnabled: false,
        showSelectedIcon: false,
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
        segments: genders.map((size) {
          return ButtonSegment(
              icon: Icon(genderIcons[genders.indexOf(size)]),
              value: size,
              label: Text(size, style: const TextStyle(fontSize: 12)));
        }).toList(),
        selected: {selectedGender},
        onSelectionChanged: (newSelection) {
          // Ocultamos el teclado al hacer tap en cualquier parte de la pantalla
          FocusScope.of(context).unfocus();
          onGenderChanged(newSelection.first);
        },
      ),
    );
  }
}

class _ImageGallery extends StatelessWidget {
  final List<String> images;
  const _ImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {
    // Si no hay imágenes, mostramos una imagen por defecto
    if (images.isEmpty) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Image.asset(
          'assets/images/no-image.jpg',
          fit: BoxFit.cover,
        ),
      );
    }

    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(viewportFraction: 0.7),
      children: images.map((image) {
        /// Determinamos si la imagen es una URL o un asset para cargarla de la forma adecuada
        /// Para ello, primero definimos una variable tardía de tipo ImageProvider
        /// y luego la asignamos dependiendo del tipo de la imagen.
        late ImageProvider imageProvider;
        if (image.startsWith('http')) {
          imageProvider = NetworkImage(image);
        } else {
          imageProvider = FileImage(File(image));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: FadeInImage(
              fit: BoxFit.cover,
              image: imageProvider,
              placeholder: AssetImage('assets/loaders/bottle-loader.gif'),
            ),
          ),
        );
      }).toList(),
    );
  }
}

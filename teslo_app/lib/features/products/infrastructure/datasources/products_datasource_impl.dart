import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infrastructure/errors/product_errors.dart';

import '../mappers/product_mapper.dart';

class ProductsDatasourceImpl extends ProductsDatasource {
  /// Solicitamos la instancia de Dio y el token de acceso
  late final Dio dio;
  final String accessToken;

  // Inicializamos el constructor con el token de acceso
  ProductsDatasourceImpl({
    required this.accessToken,
  }) : dio = Dio(
          // Inicializamos la instancia de Dio
          BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ),
        );

  Future<String> _uploadFile(String path) async {
    try {
      // Obtenemos el nombre del archivo con extensión
      final fileName = path.split('/').last;

      // Creamos un objeto FormData con el archivo a subir
      final FormData data = FormData.fromMap({
        // Creamos un objeto MultipartFile con el archivo a subir
        'file': MultipartFile.fromFileSync(path, filename: fileName),
      });

      // Realizamos la petición POST a la API
      final response = await dio.post('/files/product', data: data);

      return response.data['image'];
    } catch (e) {
      throw Exception();
    }
  }

  /// Método para subir las fotos de un producto a la API
  Future<List<String>> _uploadPhotos(List<String> photos) async {
    // Filtramos las fotos que no están subidas a la API
    final photosToUpload =
        photos.where((photo) => photo.contains('/')).toList();

    // Filtramos las fotos que ya están subidas a la API
    final photosToIgnore =
        photos.where((photo) => !photo.contains('/')).toList();

    // Creamos una lista de trabajos de subida de fotos
    final List<Future<String>> uploadJob =
        photosToUpload.map((e) => _uploadFile(e)).toList();

    // Esperamos a que se completen todos los trabajos de subida de fotos
    final newImages = await Future.wait(uploadJob);

    // Retornamos las fotos que ya estaban subidas a la API y las nuevas fotos subidas
    return [...photosToIgnore, ...newImages];
  }

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      // Obtenemos el id del producto
      final String? productId = productLike['id'];

      // Obtenemos el método HTTP a utilizar
      final String method = productId == null ? 'POST' : 'PATCH';

      // Obtenemos la URL a utilizar
      final String url =
          productId == null ? '/products' : '/products/$productId';

      // Eliminamos el id del producto para evitar errores en la petición
      productLike.remove('id');

      // Reemplazamos las fotos del producto por las fotos subidas a la API
      productLike['images'] = await _uploadPhotos(productLike['images']);

      // Realizamos la petición POST o PATCH a la API
      final response = await dio.request(
        url,
        data: productLike,
        options: Options(
          method: method,
        ),
      );

      // Mapeamos el JSON a una entidad de tipo Product
      final product = ProductMapper.jsonToEntity(response.data);

      return product;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      // Realizamos la petición GET a la API
      final response = await dio.get('/products/$id');

      // Mapeamos el JSON a una entidad de tipo Product
      final product = ProductMapper.jsonToEntity(response.data);

      return product;
    } on DioException catch (e) {
      // Si el producto no existe, se lanza un error 404
      if (e.response?.statusCode == 404) {
        throw ProductNotFound();
      }

      // Si ocurre un error en la petición, se lanza una excepción
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Product>> getProductsByPage(
      {int limit = 10, int offset = 0}) async {
    // Realizamos la petición GET a la API
    final response =
        await dio.get<List>('/products?limit=$limit&offset=$offset');

    // Creamos una lista de productos vacía
    final List<Product> products = [];

    // Recorremos la respuesta de la API, si la respuesta es nula se asigna una lista vacía
    for (var product in response.data ?? []) {
      // Mapeamos el JSON a una entidad de tipo Product
      products.add(ProductMapper.jsonToEntity(product));
    }

    return products;
  }

  @override
  Future<List<Product>> searchProductsByQuery(String query) {
    // TODO: implement searchProductsByQuery
    throw UnimplementedError();
  }
}

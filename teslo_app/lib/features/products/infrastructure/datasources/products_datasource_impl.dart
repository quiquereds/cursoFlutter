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

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      final String? productId = productLike['id'];
      final String method = productId == null ? 'POST' : 'PATCH';
      final String url = productId == null ? '/post' : '/products/$productId';
      productLike.remove('id');

      final response = await dio.request(
        url,
        data: productLike,
        options: Options(
          method: method,
        ),
      );

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

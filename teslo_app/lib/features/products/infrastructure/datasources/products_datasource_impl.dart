import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';

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
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
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

import 'package:teslo_shop/features/products/domain/entities/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0});
  Future<Product> getProductById(String id);

  Future<List<Product>> searchProductsByQuery(String query);
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike);
}

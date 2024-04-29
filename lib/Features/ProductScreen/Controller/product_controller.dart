import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Models/product_model.dart';
import '../Repository/product_repository.dart';

final fetchProductProvider = FutureProvider.autoDispose<List<Product>>((ref) {
  return ref.watch(productControllerProvider).fetchProducts();
});
final productControllerProvider = Provider(
  (ref) => ProductController(repository: ref.watch(productRepositoryProvider)),
);

class ProductController {
  final ProductRepository _repository;
  ProductController({required ProductRepository repository})
      : _repository = repository;

  Future<List<Product>> fetchProducts() async {
    return _repository.fetchProducts();
  }
}

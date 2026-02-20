import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/repositories/product_repo.dart';

class GetProductsForCategoryUseCase {
  final ProductRepository repository;

  GetProductsForCategoryUseCase({required this.repository});

  Future<Either<Exceptions, List<ProductEntity>>> call(
    String categoryId, {
    int limit = -1,
  }) async {
    return await repository.getProductsForCategory(categoryId, limit: limit);
  }
}

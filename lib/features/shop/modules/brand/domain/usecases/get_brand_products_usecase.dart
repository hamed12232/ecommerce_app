import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/repositories/base_brand_repository.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';

class GetBrandProductsUseCase {
  final BaseBrandRepository repository;

  GetBrandProductsUseCase({required this.repository});

  Future<Either<Exceptions, List<ProductEntity>>> call(
    String brandId, {
    int limit = -1,
  }) async {
    return await repository.getProductsForBrand(brandId, limit: limit);
  }
}

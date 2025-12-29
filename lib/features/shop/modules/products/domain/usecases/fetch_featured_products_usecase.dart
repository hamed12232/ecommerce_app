import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/repositories/product_repo.dart';

class FetchFeaturedProductsUseCase {
  final ProductRepository repository;

  FetchFeaturedProductsUseCase({required this.repository});

  Future<Either<Exceptions, List<ProductEntity>>> call() async {
    return await repository.getFeaturedProducts();
  }
}

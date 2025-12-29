import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/repositories/product_repo.dart';

class UploadProductsUseCase {
  final ProductRepository repository;

  UploadProductsUseCase({required this.repository});

  Future<Either<Exceptions, void>> call(List<ProductEntity> products) async {
    return await repository.uploadDummyData(products);
  }
}

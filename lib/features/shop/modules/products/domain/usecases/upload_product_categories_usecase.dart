import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_category_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/repositories/product_repo.dart';

class UploadProductCategoriesUseCase {
  final ProductRepository repository;

  UploadProductCategoriesUseCase({required this.repository});

  Future<Either<Exceptions, void>> call(
    List<ProductCategoryModel> productCategories,
  ) async {
    return await repository.uploadProductCategories(productCategories);
  }
}

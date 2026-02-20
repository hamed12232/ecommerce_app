import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/brand/data/models/brand_category_model.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/repositories/base_brand_repository.dart';

class UploadBrandCategoriesUseCase {
  final BaseBrandRepository repository;

  UploadBrandCategoriesUseCase({required this.repository});

  Future<Either<Exceptions, void>> call(
    List<BrandCategoryModel> brandCategories,
  ) async {
    return await repository.uploadBrandCategories(brandCategories);
  }
}

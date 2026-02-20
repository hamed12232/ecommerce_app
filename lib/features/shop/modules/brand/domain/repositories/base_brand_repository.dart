import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/brand/data/models/brand_category_model.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/entities/brand_entity.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';

abstract class BaseBrandRepository {
  Future<Either<Exceptions, List<BrandEntity>>> getBrands();
  Future<Either<Exceptions, List<ProductEntity>>> getProductsForBrand(
    String brandId, {
    int limit = -1,
  });
  Future<Either<Exceptions, List<BrandEntity>>> getBrandsForCategory(
    String categoryId,
  );
  Future<Either<Exceptions, void>> uploadBrands(List<BrandEntity> brands);
  Future<Either<Exceptions, void>> uploadBrandCategories(
    List<BrandCategoryModel> brandCategories,
  );
  Future<Either<Exceptions, String>> uploadImage(String path, dynamic image);
}

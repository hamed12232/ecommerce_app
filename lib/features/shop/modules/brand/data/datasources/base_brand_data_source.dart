import 'package:ecommerce_app/features/shop/modules/brand/data/models/brand_category_model.dart';
import 'package:ecommerce_app/features/shop/modules/brand/data/models/brand_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_model.dart';

abstract class BaseBrandDataSource {
  Future<List<BrandModel>> getBrands();
  Future<List<ProductModel>> getProductsForBrand({
    required String brandId,
    int limit = -1,
  });
  Future<List<BrandModel>> getBrandsForCategory(String categoryId);
  Future<void> uploadBrands(List<BrandModel> brands);
  Future<void> uploadBrandCategories(List<BrandCategoryModel> brandCategories);
  Future<String> uploadImage(String path, dynamic image);
}

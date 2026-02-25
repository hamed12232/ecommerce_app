import 'package:ecommerce_app/features/shop/modules/home/data/models/category_model.dart';

abstract class BaseCategoryDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<CategoryModel>> getSubCategories(String categoryId);
  Future<void> uploadCategories(List<CategoryModel> categories);
  Future<String> uploadImage(String path, dynamic image);
}

import 'package:ecommerce_app/features/shop/modules/home/data/models/category_model.dart';

abstract class BaseCategoryDataSource {
  Future<List<CategoryModel>> getCategories();
}
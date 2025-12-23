import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/category_entity.dart';

abstract class BaseCategoryRepository {
  Future<Either<Exceptions, List<CategoryEntity>>> getCategories();
}

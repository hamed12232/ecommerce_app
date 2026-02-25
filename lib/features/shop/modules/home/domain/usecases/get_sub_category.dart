import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/repositories/base_category_repository.dart';

class GetSubCategory {
  final BaseCategoryRepository baseCategoryRepository;

  GetSubCategory({required this.baseCategoryRepository});

  Future<Either<Exceptions, List<CategoryEntity>>> call(
    String categoryId,
  ) async {
    return await baseCategoryRepository.getSubCategories(categoryId);
  }
}

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/repositories/base_category_repository.dart';

class GetCategoriesUseCase {
  final BaseCategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Exceptions, List<CategoryEntity>>> call() async {
    return await repository.getCategories();
  }
}

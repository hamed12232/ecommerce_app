import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/repositories/base_category_repository.dart';

class UploadCategoriesUseCase {
  final BaseCategoryRepository repository;

  UploadCategoriesUseCase({required this.repository});

  Future<Either<Exceptions, void>> call(List<CategoryEntity> categories) async {
    return await repository.uploadCategories(categories);
  }
}

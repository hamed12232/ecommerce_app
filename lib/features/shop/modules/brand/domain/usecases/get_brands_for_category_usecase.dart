import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/entities/brand_entity.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/repositories/base_brand_repository.dart';

class GetBrandsForCategoryUseCase {
  final BaseBrandRepository repository;

  GetBrandsForCategoryUseCase({required this.repository});

  Future<Either<Exceptions, List<BrandEntity>>> call(String categoryId) async {
    return await repository.getBrandsForCategory(categoryId);
  }
}

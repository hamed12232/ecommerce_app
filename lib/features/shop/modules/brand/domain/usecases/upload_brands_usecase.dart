import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/entities/brand_entity.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/repositories/base_brand_repository.dart';

class UploadBrandsUseCase {
  final BaseBrandRepository repository;

  UploadBrandsUseCase({required this.repository});

  Future<Either<Exceptions, void>> call(List<BrandEntity> brands) async {
    return await repository.uploadBrands(brands);
  }
}

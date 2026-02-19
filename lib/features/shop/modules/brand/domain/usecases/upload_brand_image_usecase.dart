import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/repositories/base_brand_repository.dart';

class UploadBrandImageUseCase {
  final BaseBrandRepository repository;

  UploadBrandImageUseCase({required this.repository});

  Future<Either<Exceptions, String>> call(String path, dynamic image) async {
    return await repository.uploadImage(path, image);
  }
}

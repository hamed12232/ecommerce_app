import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/repositories/base_banner_repository.dart';

class UploadBannerImageUseCase {
  final BaseBannerRepository repository;

  UploadBannerImageUseCase({required this.repository});

  Future<Either<Exceptions, String>> call(String path, dynamic image) async {
    return await repository.uploadImage(path, image);
  }
}

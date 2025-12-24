import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/banner_entity.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/repositories/base_banner_repository.dart';

class UploadBannersUseCase {
  final BaseBannerRepository repository;

  UploadBannersUseCase({required this.repository});

  Future<Either<Exceptions, void>> call(List<BannerEntity> banners) async {
    return await repository.uploadBanners(banners);
  }
}

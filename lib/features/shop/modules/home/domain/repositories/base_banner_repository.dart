import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/banner_entity.dart';

abstract class BaseBannerRepository {
  Future<Either<Exceptions, List<BannerEntity>>> getBanners();
  Future<Either<Exceptions, void>> uploadBanners(List<BannerEntity> banners);
  Future<Either<Exceptions, String>> uploadImage(String path, dynamic image);
}

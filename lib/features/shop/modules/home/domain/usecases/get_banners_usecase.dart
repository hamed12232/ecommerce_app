import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/banner_entity.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/repositories/base_banner_repository.dart';

class GetBannersUseCase {
  final BaseBannerRepository repository;

  GetBannersUseCase({required this.repository});

  Future<Either<Exceptions, List<BannerEntity>>> call() async {
    return await repository.getBanners();
  }
}

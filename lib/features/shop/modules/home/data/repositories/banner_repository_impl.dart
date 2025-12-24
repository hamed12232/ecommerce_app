import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/datasources/base_banner_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/models/banner_model.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/banner_entity.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/repositories/base_banner_repository.dart';

class BannerRepositoryImpl implements BaseBannerRepository {
  final BaseBannerDataSource baseBannerDataSource;

  BannerRepositoryImpl({required this.baseBannerDataSource});

  @override
  Future<Either<Exceptions, List<BannerEntity>>> getBanners() async {
    try {
      final banners = await baseBannerDataSource.getBanners();
      return Right(banners);
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }

  @override
  Future<Either<Exceptions, void>> uploadBanners(
    List<BannerEntity> banners,
  ) async {
    try {
      final bannerModels = banners
          .map(
            (e) => BannerModel(
              id: e.id,
              imageUrl: e.imageUrl,
              targetScreen: e.targetScreen,
              active: e.active,
            ),
          )
          .toList();
      await baseBannerDataSource.uploadBanners(bannerModels);
      return const Right(null);
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }

  @override
  Future<Either<Exceptions, String>> uploadImage(
    String path,
    dynamic image,
  ) async {
    try {
      final url = await baseBannerDataSource.uploadImage(path, image);
      return Right(url);
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }
}

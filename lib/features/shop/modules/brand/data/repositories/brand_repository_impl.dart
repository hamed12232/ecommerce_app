import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/brand/data/datasources/base_brand_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/brand/data/models/brand_category_model.dart';
import 'package:ecommerce_app/features/shop/modules/brand/data/models/brand_model.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/entities/brand_entity.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/repositories/base_brand_repository.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';

class BrandRepositoryImpl implements BaseBrandRepository {
  final BaseBrandDataSource baseBrandDataSource;

  BrandRepositoryImpl({required this.baseBrandDataSource});

  @override
  Future<Either<Exceptions, List<BrandEntity>>> getBrands() async {
    try {
      final brands = await baseBrandDataSource.getBrands();
      return Right(brands);
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }

  @override
  Future<Either<Exceptions, List<ProductEntity>>> getProductsForBrand(
    String brandId, {
    int limit = -1,
  }) async {
    try {
      final products = await baseBrandDataSource.getProductsForBrand(
        brandId: brandId,
        limit: limit,
      );
      return Right(products);
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }

  @override
  Future<Either<Exceptions, List<BrandEntity>>> getBrandsForCategory(
    String categoryId,
  ) async {
    try {
      final brands = await baseBrandDataSource.getBrandsForCategory(categoryId);
      return Right(brands);
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }

  @override
  Future<Either<Exceptions, void>> uploadBrands(
    List<BrandEntity> brands,
  ) async {
    try {
      final brandModels = brands
          .map(
            (e) => BrandModel(
              id: e.id,
              name: e.name,
              image: e.image,
              isFeatured: e.isFeatured,
              productsCount: e.productsCount,
            ),
          )
          .toList();
      await baseBrandDataSource.uploadBrands(brandModels);
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
  Future<Either<Exceptions, void>> uploadBrandCategories(
    List<BrandCategoryModel> brandCategories,
  ) async {
    try {
      await baseBrandDataSource.uploadBrandCategories(brandCategories);
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
      final url = await baseBrandDataSource.uploadImage(path, image);
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

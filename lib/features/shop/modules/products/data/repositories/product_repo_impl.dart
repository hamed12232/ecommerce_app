import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/data_sources/product_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_category_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/repositories/product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final BaseProductDataSource dataSource;

  ProductRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Exceptions, List<ProductEntity>>> getFeaturedProducts() async {
    try {
      final products = await dataSource.getFeaturedProducts();
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
  Future<Either<Exceptions, List<ProductEntity>>> getProductsForCategory(
    String categoryId, {
    int limit = -1,
  }) async {
    try {
      final products = await dataSource.getProductsForCategory(
        categoryId,
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
  Future<Either<Exceptions, void>> uploadProductCategories(
    List<ProductCategoryModel> productCategories,
  ) async {
    try {
      await dataSource.uploadProductCategories(productCategories);
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
  Future<Either<Exceptions, void>> uploadDummyData(
    List<ProductEntity> products,
  ) async {
    try {
      final productModels = products
          .map((e) => ProductModel.fromEntity(e))
          .toList();
      await dataSource.uploadDummyData(productModels);
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
  Future<Either<Exceptions, String>> uploadProductImage(
    String path,
    File image,
  ) async {
    try {
      final url = await dataSource.uploadImage(path, image);
      return Right(url);
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }
}

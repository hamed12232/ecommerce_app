import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/data/data_sources/all_product_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/domain/repositories/base_all_product_repository.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';

class AllProductRepository implements BaseAllProductRepository {
  final BaseAllProductsDataSource dataSource;

  const AllProductRepository({required this.dataSource});

  @override
  Future<Either<Exceptions, List<ProductEntity>>> getProductsByQuery(
    Query query,
  ) async {
    return _handleDataSourceCall(() => dataSource.getProductsByQuery(query));
  }

  @override
  Future<Either<Exceptions, List<ProductEntity>>>
  getAllFeaturedProducts() async {
    return _handleDataSourceCall(() => dataSource.getAllFeaturedProducts());
  }

  Future<Either<Exceptions, List<ProductEntity>>> _handleDataSourceCall(
    Future<List<ProductEntity>> Function() call,
  ) async {
    try {
      final products = await call();
      return Right(products);
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }
}

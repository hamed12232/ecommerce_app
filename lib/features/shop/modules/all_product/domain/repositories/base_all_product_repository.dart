import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';

abstract class BaseAllProductRepository {
  Future<Either<Exceptions, List<ProductEntity>>> getProductsByQuery(
    Query query,
  );
  Future<Either<Exceptions, List<ProductEntity>>> getAllFeaturedProducts();
}

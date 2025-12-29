import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Exceptions, List<ProductEntity>>> getFeaturedProducts();
  Future<Either<Exceptions, void>> uploadDummyData(
    List<ProductEntity> products,
  );
  Future<Either<Exceptions, String>> uploadProductImage(
    String path,
    File image,
  );
}

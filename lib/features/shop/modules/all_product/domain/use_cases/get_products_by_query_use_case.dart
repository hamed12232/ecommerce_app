import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/domain/repositories/base_all_product_repository.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';

class GetProductsByQueryUseCase {
  final BaseAllProductRepository repository;

  const GetProductsByQueryUseCase({required this.repository});

  Future<Either<Exceptions, List<ProductEntity>>> call(Query query) {
    return repository.getProductsByQuery(query);
  }
}

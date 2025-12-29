import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/repositories/product_repo.dart';

class UploadProductImageUseCase {
  final ProductRepository repository;

  UploadProductImageUseCase({required this.repository});

  Future<Either<Exceptions, String>> call(String path, File image) async {
    return await repository.uploadProductImage(path, image);
  }
}

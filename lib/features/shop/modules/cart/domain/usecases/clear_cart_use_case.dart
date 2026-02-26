import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/cart/domain/repositories/base_cart_repository.dart';

class ClearCartUseCase {
  final BaseCartRepository repository;

  ClearCartUseCase(this.repository);

  Future<Either<Exceptions, void>> execute() async {
    return await repository.clearCart();
  }
}

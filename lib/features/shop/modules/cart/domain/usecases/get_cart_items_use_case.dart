import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/shop/modules/cart/domain/repositories/base_cart_repository.dart';

class GetCartItemsUseCase {
  final BaseCartRepository repository;

  GetCartItemsUseCase(this.repository);

  Either<Exceptions, List<CartItemModel>> execute() {
    return repository.getCartItems();
  }
}

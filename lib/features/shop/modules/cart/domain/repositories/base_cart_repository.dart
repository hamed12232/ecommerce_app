import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/cart/data/models/cart_item_model.dart';

abstract class BaseCartRepository {
  Either<Exceptions, List<CartItemModel>> getCartItems();
  Future<Either<Exceptions, void>> saveCartItems(List<CartItemModel> items);
  Future<Either<Exceptions, void>> clearCart();
}

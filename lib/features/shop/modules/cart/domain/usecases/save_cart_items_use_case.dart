import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/shop/modules/cart/domain/repositories/base_cart_repository.dart';

class SaveCartItemsUseCase {
  final BaseCartRepository repository;

  SaveCartItemsUseCase(this.repository);

  Future<Either<Exceptions, void>> execute(List<CartItemModel> items) async {
    return await repository.saveCartItems(items);
  }
}

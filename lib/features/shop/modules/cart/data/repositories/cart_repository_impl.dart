import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/cart/data/datasources/cart_local_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/shop/modules/cart/domain/repositories/base_cart_repository.dart';

class CartRepositoryImpl implements BaseCartRepository {
  final BaseCartLocalDataSource baseCartLocalDataSource;

  CartRepositoryImpl(this.baseCartLocalDataSource);

  @override
  Either<Exceptions, List<CartItemModel>> getCartItems() {
    try {
      final result = baseCartLocalDataSource.getCartItems();
      return Right(result);
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }

  @override
  Future<Either<Exceptions, void>> saveCartItems(
    List<CartItemModel> items,
  ) async {
    try {
      await baseCartLocalDataSource.saveCartItems(items);
      return const Right(null);
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }

  @override
  Future<Either<Exceptions, void>> clearCart() async {
    try {
      await baseCartLocalDataSource.clearCart();
      return const Right(null);
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }
}

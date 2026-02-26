import 'package:ecommerce_app/features/shop/modules/cart/data/models/cart_item_model.dart';

enum CartStatus { initial, loaded, error }

class CartState {
  final CartStatus status;
  final List<CartItemModel> items;
  final String? error;

  CartState({
    this.status = CartStatus.initial,
    this.items = const [],
    this.error,
  });

  int get totalItems => items.fold(0, (sum, e) => sum + e.quantity);

  double get subtotal =>
      items.fold(0.0, (sum, e) => sum + (e.price ?? 0.0) * e.quantity);

  CartState copyWith({
    CartStatus? status,
    List<CartItemModel>? items,
    String? error,
  }) {
    return CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      error: error ?? this.error,
    );
  }
}

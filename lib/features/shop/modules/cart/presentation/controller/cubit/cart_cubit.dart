import 'package:ecommerce_app/features/shop/modules/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_app/features/shop/modules/cart/domain/usecases/clear_cart_use_case.dart';
import 'package:ecommerce_app/features/shop/modules/cart/domain/usecases/get_cart_items_use_case.dart';
import 'package:ecommerce_app/features/shop/modules/cart/domain/usecases/save_cart_items_use_case.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/controller/cubit/cart_state.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_variation_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartItemsUseCase getCartItemsUseCase;
  final SaveCartItemsUseCase saveCartItemsUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartCubit(
    this.getCartItemsUseCase,
    this.saveCartItemsUseCase,
    this.clearCartUseCase,
  ) : super(CartState()) {
    loadCart();
  }

  void loadCart() {
    final result = getCartItemsUseCase.execute();
    result.fold(
      (failure) => emit(
        state.copyWith(status: CartStatus.error, error: failure.message),
      ),
      (items) => emit(state.copyWith(status: CartStatus.loaded, items: items)),
    );
  }

  Future<void> addToCart(
    ProductEntity product, {
    int quantity = 1,
    ProductVariationModel? variation,
  }) async {
    final currentItems = List<CartItemModel>.from(state.items);

    // Check if the exact product/variation already exists
    final variationId = variation?.id ?? '';
    final existingIndex = currentItems.indexWhere(
      (item) => item.productId == product.id && item.variationId == variationId,
    );

    if (existingIndex >= 0) {
      // Increment quantity
      final existingItem = currentItems[existingIndex];
      currentItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
    } else {
      final price = variation != null
          ? (variation.salePrice != null && variation.salePrice! > 0
                ? variation.salePrice!
                : variation.price)
          : (product.salePrice != null && product.salePrice! > 0
                ? product.salePrice!
                : product.price);

      final newItem = CartItemModel(
        productId: product.id,
        variationId: variationId,
        quantity: quantity,
        price: price,
        title: product.title,
        brandName: product.brand?.name,
        image: variation?.image.isNotEmpty == true
            ? variation!.image
            : product.thumbnail,
        selectedVariation: variation?.attributeValues,
      );
      currentItems.add(newItem);
    }

    emit(state.copyWith(items: currentItems));
    await saveCartItemsUseCase.execute(currentItems);
  }

  Future<void> removeFromCart(String productId, String variationId) async {
    final currentItems = List<CartItemModel>.from(state.items);
    currentItems.removeWhere(
      (item) => item.productId == productId && item.variationId == variationId,
    );

    emit(state.copyWith(items: currentItems));
    await saveCartItemsUseCase.execute(currentItems);
  }

  Future<void> updateQuantity(
    String productId,
    String variationId,
    int newQuantity,
  ) async {
    if (newQuantity <= 0) {
      return removeFromCart(productId, variationId);
    }

    final currentItems = List<CartItemModel>.from(state.items);
    final index = currentItems.indexWhere(
      (item) => item.productId == productId && item.variationId == variationId,
    );

    if (index >= 0) {
      currentItems[index] = currentItems[index].copyWith(quantity: newQuantity);
      emit(state.copyWith(items: currentItems));
      await saveCartItemsUseCase.execute(currentItems);
    }
  }

  Future<void> clearCart() async {
    emit(state.copyWith(items: []));
    await clearCartUseCase.execute();
  }

  bool isInCart(String productId, {String variationId = ''}) {
    return state.items.any(
      (item) => item.productId == productId && item.variationId == variationId,
    );
  }
}

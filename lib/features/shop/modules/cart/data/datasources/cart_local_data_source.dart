import 'package:ecommerce_app/core/utils/local_storage/local_storage.dart';
import 'package:ecommerce_app/features/shop/modules/cart/data/models/cart_item_model.dart';

abstract class BaseCartLocalDataSource {
  Future<void> saveCartItems(List<CartItemModel> items);
  List<CartItemModel> getCartItems();
  Future<void> clearCart();
}

class CartLocalDataSource implements BaseCartLocalDataSource {
  final TLocalStorage storage = TLocalStorage.instance();

  static const String cartKey = 'cart_items';

  @override
  Future<void> saveCartItems(List<CartItemModel> items) async {
    // Hive requires storing primitives/maps/lists of primitives if we don't use TypeAdapters.
    // We'll store a list of JSON-encoded strings or a list of Maps to be safe.
    final List<String> itemsJsonList = items
        .map((item) => item.toJson())
        .toList();
    await storage.saveData(cartKey, itemsJsonList);
  }

  @override
  List<CartItemModel> getCartItems() {
    final result = storage.readData<List<dynamic>>(cartKey);
    if (result == null) return [];

    return result
        .map((itemStr) => CartItemModel.fromJson(itemStr as String))
        .toList();
  }

  @override
  Future<void> clearCart() async {
    await storage.removeData(cartKey);
  }
}

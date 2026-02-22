import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';

abstract class FavouriteRepository {
  Future<void> toggleFavourite(String productId);
  bool isFavourite(String productId);
  Future<List<ProductEntity>> getFavouriteProducts();
  List<String> getFavouriteIds();
  Future<void> syncFavourites();
}

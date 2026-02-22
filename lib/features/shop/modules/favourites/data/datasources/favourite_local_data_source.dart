import 'package:ecommerce_app/core/utils/local_storage/local_storage.dart';

abstract class BaseFavouriteLocalDataSource {
  Future<void> saveFavourite(String productId);
  Future<void> removeFavourite(String productId);
  List<String> getAllFavourites();
}

class FavouriteLocalDataSource implements BaseFavouriteLocalDataSource {
  final TLocalStorage storage = TLocalStorage.instance();

  static const String favouritesKey = 'favourite_ids';

  @override
  Future<void> saveFavourite(String productId) async {
    final favourites = getAllFavourites();
    if (!favourites.contains(productId)) {
      favourites.add(productId);
      await storage.saveData(favouritesKey, favourites);
    }
  }

  @override
  Future<void> removeFavourite(String productId) async {
    final favourites = getAllFavourites();
    if (favourites.contains(productId)) {
      favourites.remove(productId);
      await storage.saveData(favouritesKey, favourites);
    }
  }

  @override
  List<String> getAllFavourites() {
    final result = storage.readData<List<dynamic>>(favouritesKey);
    return result?.cast<String>() ?? [];
  }
}

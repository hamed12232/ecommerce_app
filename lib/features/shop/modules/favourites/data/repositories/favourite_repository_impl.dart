import 'package:ecommerce_app/features/shop/modules/favourites/data/datasources/favourite_local_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/favourites/data/datasources/favourite_remote_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/favourites/domain/repositories/favourite_repository.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/data_sources/product_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavouriteRepositoryImpl implements FavouriteRepository {
  final BaseFavouriteLocalDataSource localDataSource;
  final BaseFavouriteRemoteDataSource remoteDataSource;
  final BaseProductDataSource productDataSource;

  FavouriteRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.productDataSource,
  });

  @override
  Future<void> toggleFavourite(String productId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (isFavourite(productId)) {
      await localDataSource.removeFavourite(productId);
      if (user != null) {
        await remoteDataSource.removeFavourite(user.uid, productId);
      }
    } else {
      await localDataSource.saveFavourite(productId);
      if (user != null) {
        await remoteDataSource.saveFavourite(user.uid, productId);
      }
    }
  }

  @override
  bool isFavourite(String productId) {
    return localDataSource.getAllFavourites().contains(productId);
  }

  @override
  List<String> getFavouriteIds() {
    return localDataSource.getAllFavourites();
  }

  @override
  Future<List<ProductEntity>> getFavouriteProducts() async {
    final favouriteIds = localDataSource.getAllFavourites();
    if (favouriteIds.isEmpty) return [];

    final products = await productDataSource.getProductsByIds(favouriteIds);
    return products;
  }

  @override
  Future<void> syncFavourites() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // 1. Fetch remote IDs
      final remoteIds = await remoteDataSource.getFavouriteIds(user.uid);

      // 2. Fetch local IDs
      final localIds = localDataSource.getAllFavourites();

      // 3. Merge IDs (Union)
      final mergedIds = <String>{...localIds, ...remoteIds};

      // 4. Update Local Storage
      for (final id in mergedIds) {
        if (!localIds.contains(id)) {
          await localDataSource.saveFavourite(id);
        }
      }

      // 5. Update Remote Storage (Push local IDs that weren't remote)
      for (final id in localIds) {
        if (!remoteIds.contains(id)) {
          await remoteDataSource.saveFavourite(user.uid, id);
        }
      }
    } catch (e) {
      // Log or handle error if needed, but don't break the app flow
      rethrow;
    }
  }
}

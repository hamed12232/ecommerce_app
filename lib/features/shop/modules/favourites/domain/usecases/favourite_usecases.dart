import 'package:ecommerce_app/features/shop/modules/favourites/domain/repositories/favourite_repository.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';

class ToggleFavouriteUseCase {
  final FavouriteRepository repository;
  ToggleFavouriteUseCase({required this.repository});

  Future<void> call(String productId) async {
    return await repository.toggleFavourite(productId);
  }
}

class IsFavouriteUseCase {
  final FavouriteRepository repository;
  IsFavouriteUseCase({required this.repository});

  bool call(String productId) {
    return repository.isFavourite(productId);
  }
}

class GetFavouriteProductsUseCase {
  final FavouriteRepository repository;
  GetFavouriteProductsUseCase({required this.repository});

  Future<List<ProductEntity>> call() async {
    return await repository.getFavouriteProducts();
  }
}

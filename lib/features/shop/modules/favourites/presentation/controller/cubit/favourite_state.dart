import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FavouriteState extends Equatable {
  final List<String> favouriteIds;
  const FavouriteState(this.favouriteIds);

  @override
  List<Object?> get props => [favouriteIds];
}

class FavouriteInitial extends FavouriteState {
  const FavouriteInitial() : super(const []);
}

class FavouriteUpdated extends FavouriteState {
  const FavouriteUpdated(super.favouriteIds);
}

class FavouriteLoading extends FavouriteState {
  const FavouriteLoading(super.favouriteIds);
}

class FavouriteLoaded extends FavouriteState {
  final List<ProductEntity> products;
  const FavouriteLoaded(super.favouriteIds, this.products);

  @override
  List<Object?> get props => [favouriteIds, products];
}

class FavouriteError extends FavouriteState {
  final String message;
  const FavouriteError(super.favouriteIds, this.message);

  @override
  List<Object?> get props => [favouriteIds, message];
}

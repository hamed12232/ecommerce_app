import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AllProductsState extends Equatable {
  const AllProductsState();

  @override
  List<Object> get props => [];
}

class AllProductsInitial extends AllProductsState {}

class AllProductsLoading extends AllProductsState {}

class AllProductsLoaded extends AllProductsState {
  final List<ProductEntity> products;

  const AllProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class AllProductsError extends AllProductsState {
  final String message;

  const AllProductsError(this.message);

  @override
  List<Object> get props => [message];
}

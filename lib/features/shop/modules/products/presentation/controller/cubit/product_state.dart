import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

enum ProductStatus { initial, loading, success, error }

class ProductState extends Equatable {
  final List<ProductEntity> featuredProducts;
  final ProductStatus status;
  final String error;

  const ProductState({
    this.featuredProducts = const [],
    this.status = ProductStatus.initial,
    this.error = '',
  });

  ProductState copyWith({
    List<ProductEntity>? featuredProducts,
    ProductStatus? status,
    String? error,
  }) {
    return ProductState(
      featuredProducts: featuredProducts ?? this.featuredProducts,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [featuredProducts, status, error];
}

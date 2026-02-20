import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

enum ProductStatus { initial, loading, success, error }

class ProductState extends Equatable {
  final List<ProductEntity> featuredProducts;
  final Map<String, List<ProductEntity>> categoryProducts;
  final ProductStatus status;
  final String error;

  const ProductState({
    this.featuredProducts = const [],
    this.categoryProducts = const {},
    this.status = ProductStatus.initial,
    this.error = '',
  });

  ProductState copyWith({
    List<ProductEntity>? featuredProducts,
    Map<String, List<ProductEntity>>? categoryProducts,
    ProductStatus? status,
    String? error,
  }) {
    return ProductState(
      featuredProducts: featuredProducts ?? this.featuredProducts,
      categoryProducts: categoryProducts ?? this.categoryProducts,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    featuredProducts,
    categoryProducts,
    status,
    error,
  ];
}

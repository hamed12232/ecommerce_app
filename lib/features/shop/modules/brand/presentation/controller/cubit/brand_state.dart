part of 'brand_cubit.dart';

enum BrandStatus { initial, loading, success, error }

class BrandState {
  final BrandStatus status;
  final List<BrandEntity> brands;
  final List<BrandEntity> featuredBrands;
  final List<ProductEntity> brandProducts;
  final String? error;

  const BrandState({
    this.status = BrandStatus.initial,
    this.brands = const [],
    this.featuredBrands = const [],
    this.brandProducts = const [],
    this.error,
  });

  BrandState copyWith({
    BrandStatus? status,
    List<BrandEntity>? brands,
    List<BrandEntity>? featuredBrands,
    List<ProductEntity>? brandProducts,
    String? error,
  }) {
    return BrandState(
      status: status ?? this.status,
      brands: brands ?? this.brands,
      featuredBrands: featuredBrands ?? this.featuredBrands,
      brandProducts: brandProducts ?? this.brandProducts,
      error: error ?? this.error,
    );
  }
}

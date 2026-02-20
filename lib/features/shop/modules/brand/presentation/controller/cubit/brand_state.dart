part of 'brand_cubit.dart';

enum BrandStatus { initial, loading, success, error }

class BrandState {
  final BrandStatus status;
  final List<BrandEntity> brands;
  final List<BrandEntity> featuredBrands;
  final List<ProductEntity> brandProducts;
  final Map<String, List<BrandEntity>> categoryBrands;
  final String? error;

  const BrandState({
    this.status = BrandStatus.initial,
    this.brands = const [],
    this.featuredBrands = const [],
    this.brandProducts = const [],
    this.categoryBrands = const {},
    this.error,
  });

  BrandState copyWith({
    BrandStatus? status,
    List<BrandEntity>? brands,
    List<BrandEntity>? featuredBrands,
    List<ProductEntity>? brandProducts,
    Map<String, List<BrandEntity>>? categoryBrands,
    String? error,
  }) {
    return BrandState(
      status: status ?? this.status,
      brands: brands ?? this.brands,
      featuredBrands: featuredBrands ?? this.featuredBrands,
      brandProducts: brandProducts ?? this.brandProducts,
      categoryBrands: categoryBrands ?? this.categoryBrands,
      error: error ?? this.error,
    );
  }
}

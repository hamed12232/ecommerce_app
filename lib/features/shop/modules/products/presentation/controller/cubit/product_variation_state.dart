import 'package:ecommerce_app/features/shop/modules/products/data/model/product_variation_model.dart';
import 'package:equatable/equatable.dart';

class ProductVariationState extends Equatable {
  final String selectedColor;
  final String selectedSize;
  final ProductVariationModel? selectedVariation;
  final String currentImage;

  const ProductVariationState({
    this.selectedColor = '',
    this.selectedSize = '',
    this.selectedVariation,
    this.currentImage = '',
  });

  ProductVariationState copyWith({
    String? selectedColor,
    String? selectedSize,
    ProductVariationModel? selectedVariation,
    String? currentImage,
  }) {
    return ProductVariationState(
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedVariation: selectedVariation ?? this.selectedVariation,
      currentImage: currentImage ?? this.currentImage,
    );
  }

  @override
  List<Object?> get props => [
    selectedColor,
    selectedSize,
    selectedVariation,
    currentImage,
  ];
}

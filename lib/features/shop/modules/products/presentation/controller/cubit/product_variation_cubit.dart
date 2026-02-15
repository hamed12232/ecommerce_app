import 'package:ecommerce_app/features/shop/modules/products/data/model/product_variation_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/controller/cubit/product_variation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductVariationCubit extends Cubit<ProductVariationState> {
  ProductVariationCubit({required this.product})
    : super(const ProductVariationState()) {
    // Initialize image with product thumbnail
    emit(state.copyWith(currentImage: product.thumbnail));
  }

  final ProductEntity product;

  void selectColor(String color) {
    emit(state.copyWith(selectedColor: color));
    _updateSelectedVariation();
  }

  void selectSize(String size) {
    emit(state.copyWith(selectedSize: size));
    _updateSelectedVariation();
  }

  void _updateSelectedVariation() {
    final variations = product.productVariations;
    if (variations == null || variations.isEmpty) {
      emit(state.copyWith(selectedVariation: null));
      return;
    }

    ProductVariationModel? match;

    for (final variation in variations) {
      final attrs = variation.attributeValues;
      bool matches = true;

      // Check color match
      if (state.selectedColor.isNotEmpty && attrs.containsKey('Color')) {
        if (attrs['Color'] != state.selectedColor) matches = false;
      }

      // Check size match
      if (state.selectedSize.isNotEmpty && attrs.containsKey('Size')) {
        if (attrs['Size'] != state.selectedSize) matches = false;
      }

      if (matches) {
        match = variation;
        break; // Stop at first match
      }
      

    }

    // Update state with match
    // If match found & has image, update image. Else revert to product thumbnail.
    emit(
      state.copyWith(
        selectedVariation: match,
        currentImage: (match != null && match.image.isNotEmpty)
            ? match.image
            : product.thumbnail,
      ),
    );
  }
}

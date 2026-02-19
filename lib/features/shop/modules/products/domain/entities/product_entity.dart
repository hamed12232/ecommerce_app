import 'package:ecommerce_app/core/utils/services/dummy_data_uploader.dart';
import 'package:ecommerce_app/features/shop/modules/brand/data/models/brand_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_attribute_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_variation_model.dart';

class ProductEntity implements UploadableEntity {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double? salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductEntity({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrice,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.productAttributes,
    this.productVariations,
  });

  /// Create Empty func for clean code
  static ProductEntity empty() => ProductEntity(
    id: '',
    title: '',
    stock: 0,
    price: 0,
    thumbnail: '',
    productType: '',
  );

  @override
  String get entityId => id;

  @override
  String get imageUrl => thumbnail;

  @override
  List<String>? get additionalImages => images;

  @override
  Map<String, String> get nestedImagePaths {
    final Map<String, String> paths = {};

    // Brand image
    if (brand != null && brand!.image.isNotEmpty) {
      paths['brand_image'] = brand!.image;
    }

    // Variation images
    if (productVariations != null) {
      for (int i = 0; i < productVariations!.length; i++) {
        final variation = productVariations![i];
        if (variation.image.isNotEmpty) {
          paths['variation_${i}_image'] = variation.image;
        }
      }
    }

    return paths;
  }

  @override
  ProductEntity copyWithImageUrl(String newImageUrl) {
    return ProductEntity(
      id: id,
      title: title,
      stock: stock,
      price: price,
      thumbnail: newImageUrl,
      productType: productType,
      sku: sku,
      brand: brand,
      date: date,
      images: images,
      salePrice: salePrice,
      isFeatured: isFeatured,
      categoryId: categoryId,
      description: description,
      productAttributes: productAttributes,
      productVariations: productVariations,
    );
  }

  @override
  ProductEntity copyWithAdditionalImages(List<String> newImages) {
    return ProductEntity(
      id: id,
      title: title,
      stock: stock,
      price: price,
      thumbnail: thumbnail,
      productType: productType,
      sku: sku,
      brand: brand,
      date: date,
      images: newImages,
      salePrice: salePrice,
      isFeatured: isFeatured,
      categoryId: categoryId,
      description: description,
      productAttributes: productAttributes,
      productVariations: productVariations,
    );
  }

  @override
  ProductEntity copyWithNestedImages(Map<String, String> uploadedUrls) {
    // Update brand image
    BrandModel? updatedBrand = brand;
    if (updatedBrand != null && uploadedUrls.containsKey('brand_image')) {
      updatedBrand = BrandModel(
        id: updatedBrand.id,
        image: uploadedUrls['brand_image']!,
        name: updatedBrand.name,
        isFeatured: updatedBrand.isFeatured,
        productsCount: updatedBrand.productsCount,
      );
    }

    // Update variation images
    List<ProductVariationModel>? updatedVariations = productVariations;
    if (updatedVariations != null) {
      updatedVariations = List.generate(updatedVariations.length, (i) {
        final key = 'variation_${i}_image';
        if (uploadedUrls.containsKey(key)) {
          final v = updatedVariations![i];
          return ProductVariationModel(
            id: v.id,
            sku: v.sku,
            image: uploadedUrls[key]!,
            description: v.description,
            price: v.price,
            salePrice: v.salePrice,
            stock: v.stock,
            attributeValues: v.attributeValues,
          );
        }
        return updatedVariations![i];
      });
    }

    return ProductEntity(
      id: id,
      title: title,
      stock: stock,
      price: price,
      thumbnail: thumbnail,
      productType: productType,
      sku: sku,
      brand: updatedBrand,
      date: date,
      images: images,
      salePrice: salePrice,
      isFeatured: isFeatured,
      categoryId: categoryId,
      description: description,
      productAttributes: productAttributes,
      productVariations: updatedVariations,
    );
  }
}

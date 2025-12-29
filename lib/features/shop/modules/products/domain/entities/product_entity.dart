import 'package:ecommerce_app/core/utils/services/dummy_data_uploader.dart';
import 'package:ecommerce_app/features/shop/modules/products/model/brand_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/model/product_attribute_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/model/product_variation_model.dart';

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
}

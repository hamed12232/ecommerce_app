import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/brand_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_attribute_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_variation_model.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.stock,
    required super.price,
    required super.thumbnail,
    required super.productType,
    super.sku,
    super.brand,
    super.date,
    super.images,
    super.salePrice,
    super.isFeatured,
    super.categoryId,
    super.description,
    super.productAttributes,
    super.productVariations,
  });

  /// Create Empty func for clean code
  static ProductModel empty() => ProductModel(
    id: '',
    title: '',
    stock: 0,
    price: 0,
    thumbnail: '',
    productType: '',
  );

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromJson(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() == null) return ProductModel.empty();
    final date = document.data()!;
    if (date.isEmpty) return ProductModel.empty();
    return ProductModel(
      id: document.id,
      title: date['title'] ?? '',
      stock: date['stock'] ?? 0,
      price: double.parse((date['price'] ?? 0).toString()),
      thumbnail: date['thumbnail'] ?? '',
      productType: date['productType'] ?? '',
      sku: date['sku'],
      brand: date['brand'] != null ? BrandModel.fromJson(date['brand']) : null,
      date: (date['date'] as Timestamp?)?.toDate(),
      images: date['images'] != null ? List<String>.from(date['images']) : [],
      salePrice: double.parse((date['salePrice'] ?? 0).toString()),
      isFeatured: date['isFeatured'] ?? false,
      categoryId: date['categoryId'],
      description: date['description'],
      productAttributes: (date['productAttributes'] as List<dynamic>?)
          ?.map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (date['productVariations'] as List<dynamic>?)
          ?.map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }

  /// Map Model to Json oriented document snapshot for Firebase
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'stock': stock,
      'price': price,
      'thumbnail': thumbnail,
      'productType': productType,
      'sku': sku,
      'brand': brand?.toJson(),
      'date': date,
      'images': images,
      'salePrice': salePrice,
      'isFeatured': isFeatured,
      'categoryId': categoryId,
      'description': description,
      'productAttributes': productAttributes?.map((e) => e.toJson()).toList(),
      'productVariations': productVariations?.map((e) => e.toJson()).toList(),
    };
  }

  /// Create object from entity
  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      title: entity.title,
      stock: entity.stock,
      price: entity.price,
      thumbnail: entity.thumbnail,
      productType: entity.productType,
      sku: entity.sku,
      brand: entity.brand,
      date: entity.date,
      images: entity.images,
      salePrice: entity.salePrice,
      isFeatured: entity.isFeatured,
      categoryId: entity.categoryId,
      description: entity.description,
      productAttributes: entity.productAttributes,
      productVariations: entity.productVariations,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/shop/modules/products/model/brand_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/model/product_attribute_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/model/product_variation_model.dart';

class ProductModel {
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

  ProductModel({
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
  static ProductModel empty() => ProductModel(id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: '');

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    final date = document.data();
    if (date!.isEmpty) return ProductModel.empty();
    return ProductModel(
      id: document.id,
      title: date['title'],
      stock: date['stock']??0,
      price: double.parse((date['price']??0).toString()),
      thumbnail: date['thumbnail'],
      productType: date['productType'],
      sku: date['sku'],
      brand: BrandModel.fromJson(document['brand']),
      date: document['date'],
      images: document['images']!=null?List<String>.from(document['images']):[],
      salePrice: double.parse((date['salePrice']??0).toString()),
      isFeatured: document['isFeatured']??false,
      categoryId: document['categoryId'],
      description: document['description'],
      productAttributes: (document['productAttributes']as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList(),
      productVariations: (document['productVariations']as List<dynamic>).map((e) => ProductVariationModel.fromJson(e)).toList(),
    );
  }

  /// Map Model to Json oriented document snapshot for Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'stock': stock,
      'price': price,
      'thumbnail': thumbnail,
      'productType': productType,
      'sku': sku,
      'brand': brand,
      'date': date,
      'images': images,
      'salePrice': salePrice,
      'isFeatured': isFeatured,
      'categoryId': categoryId,
      'description': description,
      'productAttributes': productAttributes,
      'productVariations': productVariations,
    };
  }
}

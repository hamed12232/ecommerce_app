import 'package:ecommerce_app/features/shop/modules/brand/domain/entities/brand_entity.dart';

class BrandModel extends BrandEntity {
  BrandModel({
    required super.id,
    required super.name,
    required super.image,
    super.isFeatured,
    required super.productsCount,
  });

  static BrandModel empty() => BrandModel(
    id: '',
    name: '',
    image: '',
    isFeatured: false,
    productsCount: 0,
  );

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: json['Id'] ?? json['id'] ?? '',
      name: json['Name'] ?? json['name'] ?? '',
      image: json['Image'] ?? json['image'] ?? '',
      isFeatured: json['IsFeatured'] ?? json['isFeatured'] ?? false,
      productsCount: json['ProductsCount'] ?? json['productsCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
      'ProductsCount': productsCount,
    };
  }
}

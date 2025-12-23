import 'package:ecommerce_app/features/shop/modules/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.id,
    required super.name,
    required super.image,
    required super.parentId,
    required super.isFeatured,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['Id'] ?? '',
      name: json['Name'] ?? '',
      image: json['Image'] ?? '',
      parentId: json['ParentId'] ?? '',
      isFeatured: json['IsFeatured'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    };
  }
}

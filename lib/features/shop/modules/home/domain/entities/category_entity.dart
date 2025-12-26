import 'package:ecommerce_app/core/utils/services/dummy_data_uploader.dart';

class CategoryEntity implements UploadableEntity {
  final String id;
  final String name;
  final String image;
  final String parentId;
  final bool isFeatured;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.parentId,
    required this.isFeatured,
  });

  @override
  String get imageUrl => image;

  @override
  String get entityId => name.toLowerCase().replaceAll(' ', '_');

  @override
  CategoryEntity copyWithImageUrl(String newImageUrl) {
    return CategoryEntity(
      id: id,
      name: name,
      image: newImageUrl,
      parentId: parentId,
      isFeatured: isFeatured,
    );
  }
}

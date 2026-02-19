import 'package:ecommerce_app/core/utils/services/dummy_data_uploader.dart';

class BrandEntity implements UploadableEntity {
  final String id;
  final String name;
  final String image;
  final bool? isFeatured;
  final int productsCount;

  BrandEntity({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured ,
    required this.productsCount,
  });

  @override
  String get imageUrl => image;

  @override
  String get entityId => name.toLowerCase().replaceAll(' ', '_');

  @override
  BrandEntity copyWithImageUrl(String newImageUrl) {
    return BrandEntity(
      id: id,
      name: name,
      image: newImageUrl,
      isFeatured: isFeatured,
      productsCount: productsCount,
    );
  }

  @override
  List<String>? get additionalImages => null;

  @override
  UploadableEntity copyWithAdditionalImages(List<String> newImages) {
    return this;
  }

  @override
  Map<String, String> get nestedImagePaths => {};

  @override
  UploadableEntity copyWithNestedImages(Map<String, String> uploadedUrls) {
    return this;
  }
}

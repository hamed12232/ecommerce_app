import 'package:ecommerce_app/core/utils/services/dummy_data_uploader.dart';

class BannerEntity implements UploadableEntity {
  final String id;
  @override
  final String imageUrl;
  final String targetScreen;
  final bool active;

  BannerEntity({
    required this.id,
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });

  @override
  String get entityId => id;

  @override
  BannerEntity copyWithImageUrl(String newImageUrl) {
    return BannerEntity(
      id: id,
      imageUrl: newImageUrl,
      targetScreen: targetScreen,
      active: active,
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

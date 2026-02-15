import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/core/utils/helper/network_manager.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Abstract interface that entities must implement to work with the uploader
/// Abstract interface that entities must implement to work with the uploader
abstract class UploadableEntity {
  /// Returns the image URL/path of the entity
  String get imageUrl;

  /// Returns a list of additional image URLs/paths of the entity
  List<String>? get additionalImages;

  /// Returns a unique identifier for the entity (used for file naming)
  String get entityId;

  /// Returns a map of {logicalKey: assetPath} for all nested images
  /// that need uploading (e.g., brand image, variation images).
  /// Override this in entities that have images inside sub-objects.
  Map<String, String> get nestedImagePaths => {};

  /// Creates a copy of the entity with an updated image URL
  UploadableEntity copyWithImageUrl(String newImageUrl);

  /// Creates a copy of the entity with updated additional image URLs
  UploadableEntity copyWithAdditionalImages(List<String> newImages);

  /// Creates a copy of the entity with updated nested image URLs.
  /// [uploadedUrls] is a map of {logicalKey: uploadedUrl}.
  UploadableEntity copyWithNestedImages(Map<String, String> uploadedUrls) =>
      this;
}

/// Result object returned by the uploader
class DummyDataUploadResult<T> {
  final bool success;
  final String? errorMessage;
  final List<T>? updatedEntities;

  const DummyDataUploadResult._({
    required this.success,
    this.errorMessage,
    this.updatedEntities,
  });

  factory DummyDataUploadResult.success(List<T> entities) =>
      DummyDataUploadResult._(success: true, updatedEntities: entities);

  factory DummyDataUploadResult.error(String message) =>
      DummyDataUploadResult._(success: false, errorMessage: message);

  factory DummyDataUploadResult.noInternet() => const DummyDataUploadResult._(
    success: false,
    errorMessage: 'No Internet Connection',
  );
}

/// Configuration for the uploader
class DummyDataUploaderConfig {
  /// The folder name in storage (e.g., 'banners', 'categories')
  final String storageFolderName;

  /// File extension for uploaded images
  final String fileExtension;

  const DummyDataUploaderConfig({
    required this.storageFolderName,
    this.fileExtension = 'png',
  });
}

/// Generic class to upload dummy data with images for any entity type
class DummyDataUploader<T extends UploadableEntity> {
  final Future<Either<Exceptions, String>> Function(String path, File file)
  uploadImage;
  final Future<Either<Exceptions, void>> Function(List<T> entities)
  uploadEntities;
  final DummyDataUploaderConfig config;

  DummyDataUploader({
    required this.uploadImage,
    required this.uploadEntities,
    required this.config,
  });

  /// Uploads dummy data with image handling
  ///
  /// Returns a [DummyDataUploadResult] containing:
  /// - success status
  /// - error message if failed
  /// - updated entities with new image URLs if successful
  Future<DummyDataUploadResult<T>> uploadDummyData(List<T> entities) async {
    // Check internet connection
    final isInternetConnected = await NetworkManager.instance.isConnected();
    if (!isInternetConnected) {
      return DummyDataUploadResult<T>.noInternet();
    }

    try {
      final List<T> updatedEntities = [];

      for (var entity in entities) {
        // 1. Upload Main Image
        String imageUrl = entity.imageUrl;
        if (imageUrl.startsWith('assets/')) {
          imageUrl = await _uploadSingleImage(imageUrl, entity.entityId);
        }

        // 2. Upload Additional Images
        List<String> updatedAdditionalImages = [];
        if (entity.additionalImages != null &&
            entity.additionalImages!.isNotEmpty) {
          int index = 0;
          for (var img in entity.additionalImages!) {
            if (img.startsWith('assets/')) {
              final uploadedUrl = await _uploadSingleImage(
                img,
                '${entity.entityId}_$index',
              );
              updatedAdditionalImages.add(uploadedUrl);
            } else {
              updatedAdditionalImages.add(img);
            }
            index++;
          }
        }

        // 3. Upload Nested Images (e.g., brand.image, variation images)
        Map<String, String> uploadedNestedUrls = {};
        final nestedPaths = entity.nestedImagePaths;
        for (var entry in nestedPaths.entries) {
          if (entry.value.isNotEmpty && entry.value.startsWith('assets/')) {
            final uploadedUrl = await _uploadSingleImage(
              entry.value,
              '${entity.entityId}_${entry.key}',
            );
            uploadedNestedUrls[entry.key] = uploadedUrl;
          } else {
            uploadedNestedUrls[entry.key] = entry.value;
          }
        }

        // 4. Update Entity
        var updatedEntity = entity.copyWithImageUrl(imageUrl);
        if (updatedAdditionalImages.isNotEmpty) {
          updatedEntity = updatedEntity.copyWithAdditionalImages(
            updatedAdditionalImages,
          );
        }
        if (uploadedNestedUrls.isNotEmpty) {
          updatedEntity = updatedEntity.copyWithNestedImages(
            uploadedNestedUrls,
          );
        }

        updatedEntities.add(updatedEntity as T);
      }

      final result = await uploadEntities(updatedEntities);

      return result.fold(
        (failure) => DummyDataUploadResult<T>.error(failure.message),
        (_) => DummyDataUploadResult<T>.success(updatedEntities),
      );
    } catch (e) {
      return DummyDataUploadResult<T>.error(
        'Failed to upload images: ${e.toString()}',
      );
    }
  }

  Future<String> _uploadSingleImage(String assetPath, String imageName) async {
    final byteData = await rootBundle.load(assetPath);
    final bytes = byteData.buffer.asUint8List();

    // Create a temporary file
    final tempDir = await getTemporaryDirectory();
    final fileName = '$imageName.${config.fileExtension}';
    final file = await File('${tempDir.path}/$fileName').create();
    await file.writeAsBytes(bytes);

    final uploadResult = await uploadImage(
      '${config.storageFolderName}/$fileName',
      file,
    );

    // Clean up the temporary file
    if (await file.exists()) {
      await file.delete();
    }

    return uploadResult.fold(
      (failure) => throw Exception(failure.message),
      (url) => url,
    );
  }
}

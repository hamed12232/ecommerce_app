import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/core/utils/helper/network_manager.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Abstract interface that entities must implement to work with the uploader
abstract class UploadableEntity {
  /// Returns the image URL/path of the entity
  String get imageUrl;

  /// Returns a unique identifier for the entity (used for file naming)
  String get entityId;

  /// Creates a copy of the entity with an updated image URL
  UploadableEntity copyWithImageUrl(String newImageUrl);
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
        String imageUrl = entity.imageUrl;

        // If image is a local asset, upload it to storage
        if (imageUrl.startsWith('assets/')) {
          final byteData = await rootBundle.load(imageUrl);
          final bytes = byteData.buffer.asUint8List();

          // Create a temporary file
          final tempDir = await getTemporaryDirectory();
          final fileName = '${entity.entityId}.${config.fileExtension}';
          final file = await File('${tempDir.path}/$fileName').create();
          await file.writeAsBytes(bytes);

          final uploadResult = await uploadImage(
            '${config.storageFolderName}/$fileName',
            file,
          );

          imageUrl = uploadResult.fold(
            (failure) => throw Exception(failure.message),
            (url) => url,
          );

          // Clean up the temporary file
          if (await file.exists()) {
            await file.delete();
          }
        }

        updatedEntities.add(entity.copyWithImageUrl(imageUrl) as T);
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
}

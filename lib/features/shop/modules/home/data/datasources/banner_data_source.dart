import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/datasources/base_banner_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/models/banner_model.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BannerDataSource implements BaseBannerDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<List<BannerModel>> getBanners() async {
    try {
      final banners = await firestore
          .collection('banners')
          .where('Active', isEqualTo: true)
          .get();
      return banners.docs
          .map((doc) => BannerModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> uploadBanners(List<BannerModel> banners) async {
    try {
      for (var banner in banners) {
        await firestore
            .collection('banners')
            .doc(banner.id)
            .set(banner.toJson());
      }
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<String> uploadImage(String path, dynamic image) async {
    try {
      final bucket = Supabase.instance.client.storage.from('images');
      final response = await bucket.upload(
        path,
        image as File,
        fileOptions: const FileOptions(upsert: true),
      );

      if (response.isEmpty) throw Exception("Upload failed");

      final publicUrl = bucket.getPublicUrl(path);
      return publicUrl;
    } on StorageException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}

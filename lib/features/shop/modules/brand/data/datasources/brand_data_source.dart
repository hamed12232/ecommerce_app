import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/brand/data/datasources/base_brand_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/brand/data/models/brand_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_model.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BrandDataSource implements BaseBrandDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<BrandModel>> getBrands() async {
    try {
      final brands = await firestore.collection('Brands').get();
      return brands.docs.map((doc) => BrandModel.fromJson(doc.data())).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<ProductModel>> getProductsForBrand({
    required String brandId,
    int limit = -1,
  }) async {
    try {
      final querySnapshot = limit == -1
          ? await firestore
                .collection('Products')
                .where('brand.id', isEqualTo: brandId)
                .get()
          : await firestore
                .collection('Products')
                .where('brand.id', isEqualTo: brandId)
                .limit(limit)
                .get();

      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  @override
  Future<void> uploadBrands(List<BrandModel> brands) async {
    try {
      for (var brand in brands) {
        await firestore.collection('Brands').doc(brand.id).set(brand.toJson());
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

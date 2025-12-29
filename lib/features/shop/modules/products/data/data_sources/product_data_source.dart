import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/products/model/product_model.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseProductDataSource {
  Future<List<ProductModel>> getFeaturedProducts();
  Future<void> uploadDummyData(List<ProductModel> products);
  Future<String> uploadImage(String path, File image);
}

class ProductDataSource implements BaseProductDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _firestore
          .collection('Products')
          .where('isFeatured', isEqualTo: true)
          .limit(4)
          .get();

      return snapshot.docs.map((doc) => ProductModel.fromJson(doc)).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      final batch = _firestore.batch();
      for (var product in products) {
        final docRef = _firestore.collection('Products').doc(product.id);
        batch.set(docRef, product.toJson());
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<String> uploadImage(String path, File image) async {
    try {
      final bucket = Supabase.instance.client.storage.from('images');
      final response = await bucket.upload(
        path,
        image,
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

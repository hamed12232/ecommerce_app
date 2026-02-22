import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_category_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_model.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseProductDataSource {
  Future<List<ProductModel>> getFeaturedProducts();
  Future<List<ProductModel>> getProductsForCategory(
    String categoryId, {
    int limit = -1,
  });
  Future<List<ProductModel>> getProductsByIds(List<String> productIds);
  Future<void> uploadProductCategories(
    List<ProductCategoryModel> productCategories,
  );
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
  Future<List<ProductModel>> getProductsForCategory(
    String categoryId, {
    int limit = -1,
  }) async {
    try {
      QuerySnapshot productCategoryQuery = await _firestore
          .collection('ProductCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();

      if (productIds.isEmpty) return [];
      final productsQuery = limit == -1
          ? await _firestore
                .collection('Products')
                .where(FieldPath.documentId, whereIn: productIds)
                .get()
          : await _firestore
                .collection('Products')
                .where(FieldPath.documentId, whereIn: productIds)
                .limit(limit)
                .get();

      return productsQuery.docs
          .map((doc) => ProductModel.fromJson(doc))
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
  Future<List<ProductModel>> getProductsByIds(List<String> productIds) async {
    try {
      if (productIds.isEmpty) return [];
      final productsQuery = await _firestore
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      return productsQuery.docs
          .map((doc) => ProductModel.fromJson(doc))
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
  Future<void> uploadProductCategories(
    List<ProductCategoryModel> productCategories,
  ) async {
    try {
      final batch = _firestore.batch();
      for (var productCategory in productCategories) {
        final docRef = _firestore.collection('ProductCategory').doc();
        batch.set(docRef, productCategory.toJson());
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

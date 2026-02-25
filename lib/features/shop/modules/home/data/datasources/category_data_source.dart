import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/datasources/base_category_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryDataSource implements BaseCategoryDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final categories = await firestore.collection('categories').get();
      return categories.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
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
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final categories = await firestore
          .collection('categories')
          .where('ParentId', isEqualTo: categoryId)
          .get();
      return categories.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
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
  Future<void> uploadCategories(List<CategoryModel> categories) async {
    try {
      for (var category in categories) {
        await firestore
            .collection('categories')
            .doc(category.id)
            .set(category.toJson());
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

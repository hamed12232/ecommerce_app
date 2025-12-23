import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/datasources/base_category_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/home/data/models/category_model.dart';
import 'package:flutter/services.dart';

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
}

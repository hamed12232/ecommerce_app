import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_model.dart';
import 'package:flutter/services.dart';

abstract class BaseAllProductsDataSource {
  Future<List<ProductModel>> getProductsByQuery(Query query);
  Future<List<ProductModel>> getAllFeaturedProducts();
}

class AllProductsDataSource implements BaseAllProductsDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<ProductModel>> getProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map(
            (e) => ProductModel.fromQuerySnapshot(
              e as QueryDocumentSnapshot<Map<String, dynamic>>,
            ),
          )
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _firestore
          .collection('Products')
          .where('isFeatured', isEqualTo: true)
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
}

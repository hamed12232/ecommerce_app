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
    return _handleFirestoreCall(() async {
      final querySnapshot = await query.get();
      return querySnapshot.docs
          .map(
            (doc) => ProductModel.fromQuerySnapshot(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>,
            ),
          )
          .toList();
    });
  }

  @override
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    return _handleFirestoreCall(() async {
      final snapshot = await _firestore
          .collection('Products')
          .where('isFeatured', isEqualTo: true)
          .get();

      return snapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    });
  }

  Future<List<ProductModel>> _handleFirestoreCall(
    Future<List<ProductModel>> Function() call,
  ) async {
    try {
      return await call();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}

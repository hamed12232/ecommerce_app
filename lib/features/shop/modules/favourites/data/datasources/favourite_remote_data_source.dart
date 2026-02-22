import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';

abstract class BaseFavouriteRemoteDataSource {
  Future<void> saveFavourite(String userId, String productId);
  Future<void> removeFavourite(String userId, String productId);
  Future<List<String>> getFavouriteIds(String userId);
}

class FavouriteRemoteDataSource implements BaseFavouriteRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String collectionPath = 'UsersFavourites';

  @override
  Future<void> saveFavourite(String userId, String productId) async {
    try {
      await _firestore.collection(collectionPath).doc(userId).set({
        'productIds': FieldValue.arrayUnion([productId]),
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> removeFavourite(String userId, String productId) async {
    try {
      await _firestore.collection(collectionPath).doc(userId).update({
        'productIds': FieldValue.arrayRemove([productId]),
      });
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<String>> getFavouriteIds(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(collectionPath)
          .doc(userId)
          .get();
      if (snapshot.exists && snapshot.data() != null) {
        final data = snapshot.data()!;
        return List<String>.from(data['productIds'] ?? []);
      }
      return [];
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}

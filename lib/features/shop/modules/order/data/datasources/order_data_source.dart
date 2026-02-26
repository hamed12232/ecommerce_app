import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/shop/modules/order/data/datasources/base_order_data_source.dart';
import 'package:ecommerce_app/features/shop/modules/order/data/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class OrderDataSource implements BaseOrderDataSource {
  OrderDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  String _currentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw AppFirebaseException('no-user');
    }
    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> _ordersRef(String userId) {
    return _firestore.collection('users').doc(userId).collection('Orders');
  }

  @override
  Future<void> saveOrder(OrderModel order) async {
    try {
      final userId = _currentUserId();
      await _ordersRef(userId).doc(order.id).set(order.toMap());
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = _currentUserId();
      final snapshot = await _ordersRef(
        userId,
      ).orderBy('orderDate', descending: true).get();

      return snapshot.docs
          .map((doc) => OrderModel.fromMap({...doc.data(), 'id': doc.id}))
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

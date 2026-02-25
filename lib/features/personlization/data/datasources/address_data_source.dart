import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/personlization/data/datasources/base_address_data_source.dart';
import 'package:ecommerce_app/features/personlization/data/models/address_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AddressDataSource implements BaseAddressDataSource {
  AddressDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _userAddressesRef(String userId) {
    // Store addresses under Users/{uid}/Addresses
    return _firestore.collection('users').doc(userId).collection('Addresses');
  }

  String _currentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw AppFirebaseException('no-user');
    }
    return user.uid;
  }

  @override
  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId = _currentUserId();

      final snapshot = await _userAddressesRef(userId).get();

      return snapshot.docs
          .map(
            (doc) => AddressModel.fromMap(
              {
                ...doc.data(),
                'id': doc.id,
              },
            ),
          )
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
  Future<void> addAddress(AddressModel address) async {
    try {
      final userId = _currentUserId();
      await _userAddressesRef(userId).add(
        address
            .toMap()
            .map((key, value) => MapEntry(key, key == 'id' ? null : value)),
      );
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> setPrimaryAddress(String addressId) async {
    try {
      final userId = _currentUserId();
      final ref = _userAddressesRef(userId);

      final batch = _firestore.batch();
      final snapshot = await ref.get();

      for (final doc in snapshot.docs) {
        final isSelected = doc.id == addressId;
        batch.update(doc.reference, {'selectedAddress': isSelected});
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
}


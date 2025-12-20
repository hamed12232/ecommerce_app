import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/personlization/data/datasources/base_user_data_source.dart';
import 'package:ecommerce_app/features/personlization/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserDataSource implements BaseUserDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveUserRecord(UserModel userModel) async {
    try {
      await firestore
          .collection("users")
          .doc(userModel.id)
          .set(userModel.toJson());
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> fetchUserDetails() async {
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        return UserModel.empty();
      }

      final documentSnapshot = await firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        return UserModel.fromJson(documentSnapshot.data()!);
      } else {
        return UserModel.empty();
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
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await firestore
          .collection("users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> removeUserRecord(String userId) async {
    try {
      await firestore.collection("users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code);
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}

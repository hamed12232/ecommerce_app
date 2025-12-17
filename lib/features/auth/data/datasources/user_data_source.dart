import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/auth/data/datasources/base_user_data_source.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';
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
}

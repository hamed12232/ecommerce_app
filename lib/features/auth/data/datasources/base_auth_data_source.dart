import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthDataSource {
  Future<UserCredential> signUp({
    required String email,
    required String password,
  });

  Future<void> sendEmailVerification();
}

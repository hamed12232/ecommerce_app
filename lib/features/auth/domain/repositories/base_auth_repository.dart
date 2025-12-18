import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthRepository {
  Future<Either<Exceptions, UserCredential>> signUp(
    String email,
    String password,
  );
  Future<Either<Exceptions, UserCredential>> loginWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<Exceptions, void>> sendEmailVerification();
}

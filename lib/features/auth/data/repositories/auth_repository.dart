import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_app/core/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_app/features/auth/data/datasources/base_auth_data_source.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/base_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository implements BaseAuthRepository {
  final BaseAuthDataSource baseAuthDataSource;
  AuthRepository({required this.baseAuthDataSource});
  @override
  Future<Either<Exceptions, UserCredential>> signUp(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await baseAuthDataSource.signUp(
        email: email,
        password: password,
      );
      return Right(userCredential);
    } on AppFirebaseAuthException catch (e) {
      return Left(Exceptions(e.message));
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }

  @override
  Future<Either<Exceptions, void>> sendEmailVerification() async {
    try {
      await baseAuthDataSource.sendEmailVerification();
      return const Right(null);
    } on AppFirebaseAuthException catch (e) {
      return Left(Exceptions(e.message));
    } on AppFirebaseException catch (e) {
      return Left(Exceptions(e.message));
    } on AppPlatformException catch (e) {
      return Left(Exceptions(e.message));
    } catch (e) {
      return Left(Exceptions(e.toString()));
    }
  }
}

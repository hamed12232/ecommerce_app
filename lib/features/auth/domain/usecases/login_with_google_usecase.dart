import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/base_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWithGoogleUseCase {
  final BaseAuthRepository baseAuthRepository;

  LoginWithGoogleUseCase(this.baseAuthRepository);

  Future<Either<Exceptions, UserCredential>> call() async {
    return await baseAuthRepository.loginWithGoogle();
  }
}

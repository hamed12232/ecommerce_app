import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/base_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpUseCase {
  final BaseAuthRepository repository;

  SignUpUseCase({required this.repository});

  Future<Either<Exceptions, UserCredential>> call({
    required String email,
    required String password,
  }) async {
    return await repository.signUp(email, password);
  }
}

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/base_auth_repository.dart';

class ReAuthenticateUseCase {
  final BaseAuthRepository repository;

  ReAuthenticateUseCase({required this.repository});

  Future<Either<Exceptions, void>> call(String email, String password) async {
    return await repository.reAuthenticateWithEmailAndPassword(email, password);
  }
}

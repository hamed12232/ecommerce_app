import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/base_auth_repository.dart';

class SendPasswordResetEmailUseCase {
  final BaseAuthRepository baseAuthRepository;

  SendPasswordResetEmailUseCase(this.baseAuthRepository);

  Future<Either<Exceptions, void>> call(String email) async {
    return await baseAuthRepository.sendPasswordResetEmail(email);
  }
}

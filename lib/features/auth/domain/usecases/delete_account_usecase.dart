import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/base_auth_repository.dart';

class DeleteAccountUseCase {
  final BaseAuthRepository repository;

  DeleteAccountUseCase({required this.repository});

  Future<Either<Exceptions, void>> call() async {
    return await repository.deleteAccount();
  }
}

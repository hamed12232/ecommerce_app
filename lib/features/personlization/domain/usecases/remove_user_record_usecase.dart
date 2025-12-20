import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/utils/exceptions/exceptions.dart';
import 'package:ecommerce_app/features/personlization/domain/repositories/base_user_repository.dart';

class RemoveUserRecordUseCase {
  final BaseUserRepository repository;

  RemoveUserRecordUseCase({required this.repository});

  Future<Either<Exceptions, void>> call(String userId) async {
    return await repository.removeUserRecord(userId);
  }
}
